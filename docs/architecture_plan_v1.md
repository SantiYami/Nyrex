# Nyrex — Implementation Plan & Architecture Guide

> Swiss Army knife personal toolkit · Flutter + Rust · Local-first · Horizontally scalable

---

## Table of Contents

1. [Vision & Principles](#vision--principles)
2. [Tech Stack](#tech-stack)
3. [Architecture Overview](#architecture-overview)
4. [Monorepo Structure](#monorepo-structure)
5. [Database Schema](#database-schema)
6. [Module: Password Vault](#module-password-vault)
7. [Module: Notes](#module-notes)
8. [Authentication & SSO](#authentication--sso)
9. [Full-Text Search](#full-text-search)
10. [Sync Engine](#sync-engine)
11. [Roadmap](#roadmap)
12. [Module Catalog](#module-catalog)

---

## Vision & Principles

Nyrex is a personal productivity platform designed to grow horizontally — each new module plugs into a shared core without touching existing functionality. It is not a SaaS product; it is a personal tool that you own, control, and extend.

**Core principles:**

- **Local-first.** All data lives on-device in SQLite. The backend is for sync and backup, not the source of truth. The app works fully offline.
- **Encrypted by default.** Sensitive data (passwords, private notes) is encrypted before it leaves the device. The backend never sees plaintext credentials.
- **Modules as plugins.** Every feature is a self-contained module with a defined interface. Adding a new module never breaks existing ones.
- **Fast and honest.** No loading spinners for local reads. UI reflects actual state, not optimistic guesses.
- **Portable data.** Notes are stored as Markdown. Your data is readable outside of Nyrex without any export step.

---

## Tech Stack

| Layer | Technology | Rationale |
| --- | --- | --- |
| Mobile / Desktop / Web | Flutter | Single codebase for all platforms |
| State management | Riverpod | Scalable, testable, compile-safe |
| Local database | drift (SQLite) | Type-safe queries, reactive streams |
| Navigation | go_router | Navigator 2.0 wrapper, deep linking, auth guards |
| Rich text editor | appflowy_editor | Block-based editor (Notion-like), MD import/export |
| Secure storage | flutter_secure_storage | Keychain/Keystore for master key |
| HTTP client | dio + retrofit | Type-safe API calls |
| Backend runtime | Tokio (Rust) | Async runtime, foundation for all services |
| Web framework | Axum | Built on Tokio/hyper/tower, ergonomic, fast |
| Database | PostgreSQL + sqlx | Async native, no heavy ORM |
| Full-text search | MeiliSearch | Rust-native, typo-tolerant, trivial integration |
| Cryptography | argon2 + aes-gcm | Industry standard, Rust crates |
| Auth | OAuth 2.0 + OIDC | Google and Microsoft SSO via `openidconnect` |
| Object storage | S3-compatible | Attachments and encrypted backups |
| Observability | tracing + OpenTelemetry | Structured logs, distributed traces |

---

## Architecture Overview

```text
┌─────────────────────────────────────────────────────────────┐
│                      Flutter App                            │
│   iOS · Android · macOS · Windows · Web                     │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐  │
│  │  🔑 Vault    │  │  📝 Notes    │  │  + future modules│  │
│  │  (local enc) │  │  (MD + rich) │  │                  │  │
│  └──────────────┘  └──────────────┘  └──────────────────┘  │
│                                                             │
│  drift (SQLite)  ·  Riverpod  ·  go_router                  │
└──────────────────────────┬──────────────────────────────────┘
                           │  REST / JWT
                           │  (sync only, not source of truth)
┌──────────────────────────▼──────────────────────────────────┐
│                   Rust Backend (Axum)                       │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐  │
│  │  API routes  │  │  Crypto lib  │  │  Sync engine     │  │
│  │  vault/notes │  │  argon2      │  │  event log/CRDT  │  │
│  │  users/auth  │  │  aes-gcm     │  │                  │  │
│  └──────────────┘  └──────────────┘  └──────────────────┘  │
│                                                             │
│  Stateless · JWT tokens · Tokio async                       │
└───────┬──────────────────┬──────────────────────────────────┘
        │                  │
┌───────▼──────┐  ┌────────▼──────┐  ┌────────────────────┐
│  PostgreSQL  │  │  MeiliSearch  │  │  S3-compatible     │
│  sqlx        │  │  Full-text    │  │  Attachments       │
│  tsvector    │  │  search index │  │  Encrypted backups │
└──────────────┘  └───────────────┘  └────────────────────┘
```

### Key architectural decisions

**The backend is a sync target, not the source of truth.** Every write goes to local SQLite first. The backend receives a sync payload asynchronously. If the network is unavailable, writes queue locally and sync when reconnected.

**The vault encryption key never leaves the device.** The master password is stretched with `argon2id` into a 256-bit key. That key lives in memory during the session and in the device's secure enclave (Keychain/Keystore). The backend stores only ciphertext.

**SSO authenticates the user to Nyrex, not to the vault.** Google/Microsoft OAuth gives you a session token for the Nyrex API. The vault master password is completely separate — it is your personal encryption key and it never touches any OAuth provider.

---

## Monorepo Structure

```text
nyrex/
├── apps/
│   └── flutter/                  # Flutter app (all platforms)
│       ├── lib/
│       │   ├── core/             # App shell, routing, theme
│       │   ├── modules/
│       │   │   ├── vault/        # Password manager module
│       │   │   ├── notes/        # Notes module
│       │   │   └── ...           # Future modules
│       │   └── shared/           # Shared widgets, utils
│       └── pubspec.yaml
│
├── services/
│   ├── api/                      # Axum HTTP API
│   │   ├── src/
│   │   │   ├── routes/           # vault.rs, notes.rs, auth.rs
│   │   │   ├── middleware/       # auth.rs, rate_limit.rs
│   │   │   └── main.rs
│   │   └── Cargo.toml
│   ├── search/                   # MeiliSearch integration
│   └── sync/                     # Sync engine
│
├── libs/
│   ├── domain/                   # Shared Rust types (User, Note, VaultEntry)
│   └── crypto/                   # Crypto primitives (argon2, aes-gcm)
│
├── infra/
│   ├── docker/
│   │   ├── docker-compose.yml    # Local dev environment
│   │   └── docker-compose.prod.yml
│   └── migrations/               # PostgreSQL migrations (sqlx)
│
├── Cargo.toml                    # Rust workspace
└── .github/
    └── workflows/
        ├── flutter-ci.yml
        └── rust-ci.yml
```

**Why a monorepo:** shared types between backend crates, unified CI/CD, cross-layer refactors in a single PR, and Rust workspaces make this the natural fit.

---

## Database Schema

### PostgreSQL (backend — canonical store for sync)

```sql
-- Users
CREATE TABLE users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email         TEXT UNIQUE NOT NULL,
  display_name  TEXT,
  sso_provider  TEXT,                    -- 'google' | 'microsoft' | null
  sso_sub       TEXT,                    -- OAuth subject claim
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Notes
CREATE TABLE notes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title         TEXT NOT NULL DEFAULT '',
  content       TEXT NOT NULL DEFAULT '',  -- Markdown or AppFlowy JSON
  format        TEXT NOT NULL DEFAULT 'markdown',  -- 'markdown' | 'appflowy'
  tags          TEXT[] DEFAULT '{}',
  is_encrypted  BOOLEAN DEFAULT FALSE,
  fts_vector    TSVECTOR GENERATED ALWAYS AS (
                  to_tsvector('english', title || ' ' || content)
                ) STORED,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ             -- soft delete
);

CREATE INDEX notes_fts_idx ON notes USING GIN(fts_vector);
CREATE INDEX notes_user_id_idx ON notes(user_id);
CREATE INDEX notes_updated_at_idx ON notes(updated_at);

-- Vault entries (always encrypted — backend never sees plaintext)
CREATE TABLE vault_entries (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  ciphertext    BYTEA NOT NULL,   -- AES-GCM encrypted blob
  nonce         BYTEA NOT NULL,   -- 12-byte GCM nonce
  hint          TEXT,             -- Optional unencrypted hint (e.g. domain name)
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ
);

-- Sync events (append-only log for conflict resolution)
CREATE TABLE sync_events (
  id            BIGSERIAL PRIMARY KEY,
  user_id       UUID NOT NULL REFERENCES users(id),
  entity_type   TEXT NOT NULL,    -- 'note' | 'vault_entry' | ...
  entity_id     UUID NOT NULL,
  operation     TEXT NOT NULL,    -- 'create' | 'update' | 'delete'
  payload       JSONB,
  client_id     TEXT NOT NULL,    -- device identifier
  created_at    TIMESTAMPTZ DEFAULT NOW()
);
```

### SQLite local schema (drift — device)

The local schema mirrors the PostgreSQL schema with two additions: a `sync_status` column (`synced` | `pending` | `conflict`) and a `local_only` flag for drafts that should not sync yet.

---

## Module: Password Vault

### Encryption model

```text
User master password
        │
        ▼
  argon2id KDF
  (salt stored locally)
        │
        ▼
  256-bit vault key  ──────────────────────────────────────┐
        │                                                  │
        ▼                                                  ▼
  AES-256-GCM encrypt                             AES-256-GCM decrypt
  (plaintext entry)                               (ciphertext from DB)
        │
        ▼
  ciphertext + nonce
  stored in DB / synced to backend
```

The vault key lives only in memory (Rust `SecretVec`) and in the device secure enclave. It is never written to disk in plaintext.

### Rust crypto crate (`libs/crypto`)

```toml
[dependencies]
argon2   = "0.5"
aes-gcm  = "0.10"
rand     = "0.8"
zeroize  = "1.7"   # zero memory on drop
```

### Flutter vault module

```dart
// lib/modules/vault/
├── data/
│   ├── vault_repository.dart     # drift queries + API sync
│   └── vault_crypto_service.dart # flutter_secure_storage + local encrypt
├── domain/
│   └── vault_entry.dart          # Freezed model
└── presentation/
    ├── vault_list_page.dart
    ├── vault_entry_detail_page.dart
    └── vault_unlock_page.dart     # master password prompt
```

---

## Module: Notes

### Storage strategy

```dart
// Field: format = 'markdown' | 'appflowy'
// Default: markdown

// Export to Markdown (always available)
final md = documentToMarkdown(editorState.document);

// Import from Markdown
final doc = markdownToDocument(markdownString);
```

Store as Markdown for 80% of notes. Switch to AppFlowy JSON only when the document uses rich blocks (toggles, callouts, embedded images). Detect automatically based on content type and set the `format` field accordingly.

### Editor setup

```dart
// pubspec.yaml
appflowy_editor: ^3.x

// lib/modules/notes/presentation/note_editor_page.dart
AppFlowyEditor(
  editorState: editorState,
  editorStyle: EditorStyle.desktop(),
  blockComponentBuilders: {
    ...standardBlockComponentBuilderMap,
    // Add custom blocks here as needed
  },
  commandShortcutEvents: standardCommandShortcutEvents,
)
```

---

## Authentication & SSO

### Flow

```text
1. User taps "Sign in with Google"
2. Flutter opens OAuth consent screen (google_sign_in package)
3. ID token sent to Axum backend
4. Backend verifies token with Google's JWKS endpoint
5. Backend upserts user record (email + sso_sub)
6. Backend issues signed JWT (RS256, 24h expiry)
7. Flutter stores JWT in flutter_secure_storage
8. All API calls include Authorization: Bearer <token>
```

### Axum auth middleware

```rust
// services/api/src/middleware/auth.rs
use axum::{middleware::Next, extract::Request, http::StatusCode};
use jsonwebtoken::{decode, DecodingKey, Validation};

pub async fn require_auth(
    mut req: Request,
    next: Next,
) -> Result<impl IntoResponse, StatusCode> {
    let token = extract_bearer_token(&req)
        .ok_or(StatusCode::UNAUTHORIZED)?;

    let claims = decode::<Claims>(&token, &DECODING_KEY, &Validation::default())
        .map_err(|_| StatusCode::UNAUTHORIZED)?;

    req.extensions_mut().insert(claims.sub);
    Ok(next.run(req).await)
}
```

### Vault master password (separate from SSO)

The vault master password is set independently after account creation. It derives the encryption key. It is never sent to the server. If lost, the vault cannot be recovered — this is by design.

---

## Full-Text Search

### MeiliSearch integration

MeiliSearch runs as a separate Docker service. Notes are indexed after every write via a background Tokio task. The search index contains only unencrypted fields (title, tags, plaintext notes). Encrypted notes are excluded from the index.

```rust
// services/api/src/routes/search.rs
use meilisearch_sdk::client::Client;

pub async fn search_notes(
    Extension(user_id): Extension<Uuid>,
    Query(params): Query<SearchParams>,
    State(meili): State<Client>,
) -> impl IntoResponse {
    let results = meili
        .index("notes")
        .search()
        .with_query(&params.q)
        .with_filter(&format!("user_id = {}", user_id))
        .execute::<NoteDocument>()
        .await?;

    Json(results.hits)
}
```

For the initial phase, PostgreSQL `tsvector` is sufficient and eliminates one service dependency. Migrate to MeiliSearch when search quality or performance becomes a bottleneck.

---

## Sync Engine

### Strategy: append-only event log

Each write generates a `sync_event` record. On reconnection, the client sends all pending events with their `client_id` and `created_at` timestamps. The server applies a last-write-wins strategy per field for simple conflicts, escalating to user-visible conflict resolution for vault entries.

### Sync states

```text
local write
    │
    ▼
SQLite (sync_status = 'pending')
    │
    ├── network available ──► POST /sync/push ──► backend applies
    │                                              │
    │                         ◄── sync_events ◄───┘ (pull remote changes)
    │
    └── network unavailable ──► queue in SQLite, retry on reconnect
```

---

## Roadmap

### Phase 1 — Core Foundation (Month 1–2)

- [ ] Monorepo setup (Cargo workspace + Flutter packages)
- [ ] PostgreSQL + sqlx migrations
- [ ] Axum API scaffold with auth middleware
- [ ] Flutter app shell with go_router and Riverpod
- [ ] drift local database setup
- [ ] **Vault module** — create, read, update, delete entries with local encryption
- [ ] **Notes module** — Markdown editor with appflowy_editor, local persistence
- [ ] Email + password authentication (no SSO yet)
- [ ] Docker Compose for local development

### Phase 2 — Sync & Search (Month 3)

- [ ] Sync engine — event log, push/pull, conflict resolution
- [ ] MeiliSearch integration (or pg_trgm as interim)
- [ ] Full-text search UI in Flutter
- [ ] Background sync with connectivity awareness
- [ ] Note tagging and filtering

### Phase 3 — SSO & Polish (Month 4)

- [ ] Google OAuth 2.0 + OIDC
- [ ] Microsoft OAuth 2.0 + OIDC
- [ ] Desktop builds (macOS, Windows)
- [ ] Encrypted backup to S3
- [ ] Vault master password change flow
- [ ] Observability: tracing, OpenTelemetry, Sentry

### Phase 4+ — Module Expansion

See Module Catalog below. Suggested order based on value/effort ratio:

1. Tasks / To-do
2. Bookmarks
3. Daily Journal
4. Time Tracker
5. Flashcards / Spaced repetition
6. Finance Tracker
7. Knowledge Graph
8. AI Assistant (local + API)

---

## Module Catalog

Each module entry follows the same format: what it does, how it integrates with
the core, and what it needs to be built.

---

### 🟢 Productivity Modules

---

#### 📋 Tasks / To-do

**What it does:** Capture and track tasks with due dates, priorities, and statuses. Not a project management tool — a personal capture system.

**Integration:** Tasks can be linked to Notes (a task references a note ID). Surfaces in the Dashboard module when built.

**Data model:**

```sql
CREATE TABLE tasks (
  id          UUID PRIMARY KEY,
  user_id     UUID REFERENCES users(id),
  title       TEXT NOT NULL,
  note_id     UUID REFERENCES notes(id),  -- optional link
  due_date    DATE,
  priority    SMALLINT DEFAULT 0,         -- 0 low, 1 medium, 2 high
  status      TEXT DEFAULT 'open',        -- 'open' | 'done' | 'archived'
  created_at  TIMESTAMPTZ,
  updated_at  TIMESTAMPTZ
);
```

**Effort:** Low. Pure CRUD with a clean Flutter UI. First module to add after core.

---

#### 🔖 Bookmarks / Read Later

**What it does:** Save URLs with auto-fetched metadata (title, description, favicon, preview image). Organize with tags and collections. Full-text search over saved content.

**Integration:** MeiliSearch already indexes bookmarks alongside notes. Tags system is shared.

**Special requirement:** A lightweight scraper service in Rust (using `scraper` crate) that fetches Open Graph metadata when a URL is saved.

**Effort:** Low-medium. The scraper adds a small async background job.

---

#### 🗓️ Daily Journal

**What it does:** One entry per day. Opens automatically to today's entry. Templates supported (morning pages, gratitude, work log).

**Integration:** Journal entries are Notes with `type = 'journal'` and a `date` field. No separate table needed. Tags and search work automatically.

**Effort:** Very low. Implemented as a view filter on the Notes module, plus a date-picker UI.

---

#### ⏱️ Time Tracker

**What it does:** Track time spent on projects or tasks. Start/stop timer. Weekly and monthly reports.

**Integration:** Can be linked to Tasks. Data feeds the Dashboard.

**Data model:**

```sql
CREATE TABLE time_entries (
  id          UUID PRIMARY KEY,
  user_id     UUID REFERENCES users(id),
  task_id     UUID REFERENCES tasks(id),  -- optional
  description TEXT,
  started_at  TIMESTAMPTZ NOT NULL,
  stopped_at  TIMESTAMPTZ,                -- null = currently running
  duration_s  INT GENERATED ALWAYS AS (
                EXTRACT(EPOCH FROM (stopped_at - started_at))::INT
              ) STORED
);
```

**Effort:** Low. The timer state lives in Riverpod, persisted to local SQLite.

---

#### 💰 Finance Tracker

**What it does:** Log income and expenses with categories. Monthly summaries. CSV import. No bank connectivity required.

**Integration:** Reports surface in the Dashboard. Can link expenses to projects (via Tasks).

**Effort:** Medium. The main work is the reporting UI and charts (using `fl_chart` in Flutter).

---

#### 📊 Dashboard / Home

**What it does:** Configurable home screen. Widgets that aggregate data from all modules: pending tasks, today's journal, recent notes, active timer, weekly spending.

**Integration:** This is the aggregation layer — it reads from all modules, writes to none.

**Effort:** Medium. Requires a widget system with drag-and-drop layout (consider `flutter_staggered_grid_view`).

---

### 🔵 Knowledge Modules

---

#### 🃏 Flashcards / Spaced Repetition

**What it does:** Create flashcard decks and review them using the SM-2 spaced repetition algorithm. Ideal for language learning, technical concepts, anything requiring memorization.

**Integration:** Cards can be generated from Note content (highlight a paragraph → create card). Cards link back to their source note.

**Algorithm:** SM-2 is open source, simple to implement in Rust as a pure function:

```rust
pub fn sm2_next_interval(
    ease_factor: f32,
    interval_days: u32,
    grade: u8,  // 0-5, where ≥3 is a pass
) -> (f32, u32) {
    // Returns (new_ease_factor, next_interval_days)
}
```

**Effort:** Medium. Algorithm is simple; the review UI and scheduling logic take most of the time.

---

#### 🗺️ Knowledge Graph

**What it does:** Bidirectional links between notes. A visual graph showing how your notes connect. Similar to Obsidian's graph view.

**Integration:** Links are stored as a `note_links` junction table. The graph view uses `flutter_graph_view` for visualization.

**Data model:**

```sql
CREATE TABLE note_links (
  source_note_id  UUID REFERENCES notes(id) ON DELETE CASCADE,
  target_note_id  UUID REFERENCES notes(id) ON DELETE CASCADE,
  PRIMARY KEY (source_note_id, target_note_id)
);
```

**Syntax:** `[[Note Title]]` in the editor auto-creates a link. AppFlowy editor supports custom inline elements for this.

**Effort:** Medium. Graph rendering and link parsing are the main challenges.

---

#### 📚 Reading List / Library

**What it does:** Track books read, in progress, and to read. Reading notes and highlights. Auto-fetch metadata from Open Library API (free, no key required).

**Integration:** Reading notes are stored as regular Notes with `type = 'book_note'`. Linked to a book record.

**Effort:** Low-medium. Metadata fetching is simple; the main work is the UI for tracking progress and highlights.

---

#### ✂️ Code Snippets

**What it does:** Save and organize reusable code snippets by language and tags. Syntax highlighting. Searchable. Faster than digging through old projects.

**Integration:** Snippets are a specialized Note type with `language` and `format = 'code'` fields. MeiliSearch indexes them normally.

**Flutter package:** `flutter_highlight` or `code_text_field` for syntax highlighting.

**Effort:** Low. Mostly a UI concern; the data model is a subset of Notes.

---

### 🔴 Ambitious Modules

---

#### 🤖 AI Assistant (RAG over your data)

**What it does:** Ask questions about your own knowledge base. The assistant uses Retrieval-Augmented Generation (RAG) to find relevant notes, bookmarks, and documents before answering.

**Architecture:**

```text
User query
    │
    ▼
Embed query (local model via Ollama, or OpenAI/Anthropic API)
    │
    ▼
Vector similarity search over note embeddings
    │
    ▼
Inject top-k notes as context into LLM prompt
    │
    ▼
Stream answer back to Flutter UI
```

**Storage:** Embeddings stored in PostgreSQL using `pgvector` extension.

**Integration:** Works across all modules — notes, bookmarks, journal entries, book notes all become part of the knowledge base.

**Effort:** High. Requires embedding pipeline, vector search, and LLM integration. Extremely powerful once your data accumulates.

---

#### 🔗 Integrations Hub

**What it does:** Import data from external services into Nyrex. Examples: GitHub activity → Journal entries, RSS feeds → Bookmarks, Google Calendar → Dashboard widget.

**Architecture:** A Rust background worker that runs scheduled jobs (cron-like, using `tokio-cron-scheduler`). Each integration is a separate job that fetches data and writes to the appropriate module.

**Effort:** High ongoing. Each integration is its own effort. Start with one (RSS → Bookmarks) and expand.

---

#### 🩺 Health Tracker

**What it does:** Log sleep, exercise, symptoms, weight, mood. Daily check-in. Charts over time. No dependency on Apple Health or Google Fit — your data stays in your vault.

**Integration:** Health logs are a new module with their own schema. Can surface in Dashboard. Optionally correlate with Journal entries (bad sleep → low mood pattern detection).

**Effort:** Medium. Main challenge is the charting UI and making data entry fast enough to be a daily habit.

---

#### 📡 Self-Host Dashboard

**What it does:** Monitor your personal infrastructure (Plex, Home Assistant, Nextcloud, Pi-hole, etc.) from inside Nyrex. Status indicators, uptime, basic metrics.

**Architecture:** Nyrex backend pings configured endpoints on a schedule and stores availability history. Flutter UI shows current status and uptime graphs.

**Effort:** Medium. The ping/check logic in Rust is simple; the UI for configuration and display is the main work.

---

## Module Addition Checklist

Before implementing any new module, verify:

- [ ] Used at least once per week in your workflow?
- [ ] Integrates with data already in Nyrex (notes, tasks, search)?
- [ ] Can start simple and grow incrementally?
- [ ] Does it belong in Nyrex or is there a better standalone tool?

If all four answers are yes, it belongs in Nyrex. Otherwise, reconsider.

---

## Suggested Module Order

```text
Core (Phase 1-3)
    │
    ├── Tasks ──────────────── high value, very low effort
    ├── Bookmarks ──────────── high value, low effort
    ├── Journal ────────────── free (Notes variant)
    ├── Time Tracker ───────── medium value, low effort
    ├── Flashcards ─────────── high value if you study
    ├── Finance Tracker ────── medium value, medium effort
    ├── Code Snippets ──────── high value for devs, low effort
    ├── Knowledge Graph ────── high value, medium effort
    ├── Reading List ───────── medium value, low effort
    ├── Dashboard ──────────── ties everything together
    ├── Health Tracker ─────── personal, medium effort
    ├── Integrations Hub ───── high leverage, high effort
    ├── Self-Host Dashboard ── niche, medium effort
    └── AI Assistant ───────── highest potential, highest effort
```

---

*Last updated: April 2026 · Nyrex v0.1 planning document*.

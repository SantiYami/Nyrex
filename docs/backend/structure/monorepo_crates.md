# Nyrex — Backend: Monorepo & Crate Structure

> Rust workspace layout. Axum API + shared libraries.

## Workspace Layout

```
nyrex/
├── crates/
│   ├── core/          # nyrex-core — Domain models, errors, traits
│   ├── crypto/        # AES-GCM, Argon2 pipelines, zeroize
│   ├── store/         # PostgreSQL via sqlx
│   ├── sync/          # CRDT/event log (scaffold)
│   └── search/        # Meilisearch bridge (scaffold)
│
├── services/
│   └── api/           # Axum entry point — the only running service
│       ├── src/
│       │   ├── routes/       # vault.rs, notes.rs, auth.rs, search.rs
│       │   ├── middleware/   # auth.rs, rate_limit.rs
│       │   └── main.rs
│       └── Cargo.toml
│
├── infra/
│   ├── docker/
│   │   ├── docker-compose.yml       # Local dev (PostgreSQL)
│   │   └── docker-compose.prod.yml
│   └── migrations/                  # sqlx migrations (via services/api/)
│
└── Cargo.toml                       # Workspace root
```

## Crate Responsibilities

| Crate | Purpose | Key Dependencies |
|-------|---------|-----------------|
| `nyrex-core` | Shared domain types (User, Note, VaultEntry, Task, etc.), error types, trait definitions | `serde`, `uuid` |
| `crypto` | Argon2id KDF, AES-256-GCM encrypt/decrypt, key derivation, zeroization | `argon2`, `aes-gcm`, `rand`, `zeroize` |
| `store` | PostgreSQL repository implementations via sqlx | `sqlx`, `nyrex-core` |
| `nyrex-sync` | Sync event log, conflict resolution, CRDT primitives | `nyrex-core` |
| `search` | Meilisearch indexing bridge (scaffold) | `meilisearch-sdk` |

## API Service (`services/api/`)

| Route Group | Endpoints |
|-------------|-----------|
| `/auth` | `POST /login`, `POST /register`, `POST /oauth/google`, `POST /oauth/microsoft`, `POST /refresh` |
| `/notes` | CRUD + sync push/pull |
| `/vault` | Ciphertext CRUD + sync (never decrypted server-side) |
| `/tasks` | CRUD + sync |
| `/finance` | CRUD + sync |
| `/search` | `GET /search?q=...` (FTS across unencrypted entities) |
| `/sync` | `POST /sync/push`, `GET /sync/pull?since=...` |

All endpoints behind `require_auth` middleware except `/auth/*`.

## Architecture Rules

- **Stateless API** — JWT tokens, no sessions.
- **Backend is sync target**, not source of truth.
- **No `unsafe_code`** — `#![forbid(unsafe_code)]`.
- **Logging:** `tracing` crate only, never `println!`.
- **Secrets:** `dotenvy` for env vars, fail fast if missing.

*Last updated: May 2026*

# AGENTS.md — Nyrex

## Repo Overview

Local-first productivity platform. **Flutter** frontend (mobile/desktop/web) + **Rust** backend (Axum + PostgreSQL). Data lives in local SQLite (drift); the backend is only a sync/search target. All sensitive data is AES-256-GCM encrypted client-side before sync.

## Monorepo Layout

```
crates/          # Shared Rust libraries
  core/          # Domain models, errors, traits (nyrex-core)
  crypto/        # AES-GCM, Argon2 pipelines (crypto)
  store/         # PostgreSQL via sqlx (store)
  sync/          # CRDT/event log (nyrex-sync)
  search/        # Meilisearch bridge (empty scaffold)
services/api/    # Axum entry point — the only running service
apps/flutter/    # Flutter app — Riverpod + go_router + drift
infra/docker/    # Docker Compose (PostgreSQL only)
.agents/         # Existing AI agent rules + workflows
```

## Commands

### Rust (run from repo root)

| Task | Command |
|------|---------|
| Build all | `cargo build` |
| Run API | `cargo run -p api` or `cd services/api && cargo run` |
| Lint | `cargo clippy --all-targets --all-features -- -D warnings` |
| Format check | `cargo fmt --check` |
| Format fix | `cargo fmt` |
| License audit | `cargo deny check` |

### Flutter (run from `apps/flutter/`)

| Task | Command |
|------|---------|
| Get deps | `flutter pub get` |
| Run codegen (Riverpod, drift, freezed, json_serializable) | `dart run build_runner build` |
| Run codegen (watch) | `dart run build_runner watch` |
| Lint | `flutter analyze` |
| Format | `dart format .` |
| Run app | `flutter run -d <platform>` |

### Infra

```bash
docker compose -f infra/docker/docker-compose.yml up -d   # Start PostgreSQL
```

### Order before commit

```
flutter analyze + dart format .   (apps/flutter/)
cargo clippy -- -D warnings       (root)
cargo fmt --check                 (root)
```

## Setup

1. Copy `.env.example` to `.env` and fill in `DATABASE_URL` + Ed25519 JWT key pair (Base64 encoded).
2. Start PostgreSQL: `docker compose -f infra/docker/docker-compose.yml up -d`
3. Run API: `cargo run -p api`
4. Run Flutter: `cd apps/flutter && flutter pub get && dart run build_runner build && flutter run`

## Critical Conventions

### SPDX License Header — EVERY file

Every `.rs` and `.dart` file must start with:
```
// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
```

### New Modules

Place under `apps/flutter/lib/modules/<name>/` with structure: `data/`, `domain/`, `presentation/`.

### Code Style

- Indent: 2 spaces (Dart), 4 spaces (Rust), tabs (Makefiles). LF line endings.
- Rust: no `unsafe_code` (forbid), clippy pedantic + nursery + `unwrap_used` warnings.
- Flutter: use `Riverpod` AsyncNotifier for state; avoid `setState` for complex logic.
- Rust logging: use `tracing`, never `println!`.

### Crypto & Secrets

- Never implement custom crypto. Use `argon2`, `aes-gcm`, `zeroize`.
- Keys must be zeroed after use (`zeroize::Zeroize`).
- No hardcoded secrets; fail fast with `expect`/`panic` if required env vars are missing.
- Backend must NEVER see plaintext passwords or vault entries.

### Adding Dependencies

- Verify license before adding. Allowed: MIT, Apache-2.0, BSD, ISC, Zlib, CC0-1.0.
- Denied: GPL, AGPL, or proprietary.
- Use `cargo-deny` (`deny.toml`) as source of truth for Rust crates.
- Flutter: `flutter pub add <pkg>` inside `apps/flutter/`.
- Rust: `cargo add <crate>` at workspace root or in the specific crate.

### Code Generation

Run `dart run build_runner build` in `apps/flutter/` after:
- Adding/modifying `@riverpod` providers
- Changing drift database schema definitions
- Adding/modifying `@JsonSerializable` or `@freezed` classes

### Database Migrations

- Add: `sqlx migrate add <description>` inside `services/api/`
- Run: `sqlx migrate run`
- When backend schema changes, update Flutter drift definitions manually, then regenerate.

## Existing Agent Context

Read these before making changes:
- `.agents/rules/rules.md` — Architecture rules, licensing, secret management
- `.agents/workflows/workflows.md` — Development workflows, module creation steps
- `.agents/mcp_instructions.md` — Package lookup strategy (cargo search, flutter pub search)

## Notes

- `crates/search/` and `services/sync/` are mentioned in docs but are empty/in-progress scaffolds.
- No CI workflows or pre-commit hooks configured yet.
- `scratch/` directory is for temporary experiments; do not commit artifacts there.

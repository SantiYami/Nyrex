---
trigger: always_on
---

# Nyrex Architecture & AI Coding Rules

This file serves as a strict context guide for all AI agent modifications to the Nyrex monorepo.

## 1. Core Principles

- **Local-first**: SQLite (drift via Flutter) is the absolute source of truth. All data is written locally first. The rust backend is strictly an asynchronous sync target.
- **Encrypt by Default**: All sensitive entries (passwords, secure private notes) are encrypted via AES-256-GCM *before* leaving the device. The Rust backend must NEVER see plaintext passwords or keys.
- **Horizontal Modularity**: Every new addition is a Module (e.g. `apps/flutter/lib/modules/<name>`). Do not bundle domains.
- **No SaaS Spinners**: Data should load instantly from local SQLite. We do not use optimistic UI guessings, we read local truth directly.

## 2. Tech Stack Boundaries

- **Mobile/Web**: Flutter (Dart) using Riverpod for State and go_router for declarative routing.
- **Backend API**: Rust (Tokio + Axum). Data store is PostgreSQL via `sqlx`. Full-text search delegated to `MeiliSearch`.
- **Database (Local)**: `drift` handles SQLite.
- **Cryptography**: `argon2` for stretching, `aes-gcm` for symmetric encryption.

## 3. Directory Strictness

- `apps/flutter/`: Exclusive domain of Dart/Flutter UI and offline state.
- `services/api/`: Rust Axum routing, auth middlewares.
- `services/sync/`: Backend conflict resolution engine (CRDT/Events).
- `services/search/`: Meilisearch integration jobs.
- `libs/domain/`: Pure Rust trait/struct sharing for payloads across services.
- `libs/crypto/`: Reusable crypto pipelines.
- `infra/`: Docker, CI/CD, SQLx migrations.

## 4. Coding Guardlines

- Never remove docstrings without replacing equivalent logic.
- Always implement Riverpod AsyncNotifier where possible over bare StateNotifier.
- Respect `Cargo.toml` workspace member structures. Avoid relative sibling dependency paths (`../libs/domain`) if they are already in the workspace.

## 5. Flutter Import Rules

- **Absolute Imports Only**: Never use relative paths for internal project files (e.g. `import '../core/theme.dart';`). ALWAYS use absolute paths via the package name (e.g. `import 'package:nyrex/core/theme.dart';`).
- **Barrel Files**: When importing from a directory with multiple related files (like tokens or atomic components), you MUST import the barrel file (e.g., `package:nyrex/core/theme/tokens/tokens.dart`) rather than individual component files, and you should ensure new component folders export a barrel file.

## 6. Licensing Rules

- When determining to add a new library via `cargo add` or `flutter pub add`, you MUST dynamically verify its license. It must be an OSI-approved permissive license (MIT, Apache 2.0, BSD).
- Never introduce libraries that feature GPL/AGPL (viral/copyleft) or proprietary commercial restrictions, in order to preserve our own `CC BY-NC-SA 4.0` compatibility.
- Utilize the `cargo-deny` config (`deny.toml`) as the source of truth for Rust limits.

## 7. SPDX Licensing

- Every new source file (.dart, .rs) MUST start with:

  ```text
  // SPDX-License-Identifier: CC-BY-NC-SA-4.0
  // Copyright (c) 2026 SantiYami
  ```

- This ensures automated compliance and clarity for long-term data portability.

## 8. Secret Management

- **No Hardcoded Secrets**: Never hardcode connection strings, API keys, or passwords in source code. 
- **Environment Variables**: Use `dotenvy` in Rust and `.env` files for local configuration.
- **Fail Fast**: If a required secret (like `DATABASE_URL`) is missing in a production-like environment, the app must `expect` or `panic` immediately instead of using unsafe defaults.
- **Docker Defaults**: Use `${VAR:-default}` syntax in `docker-compose.yml` to provide non-sensitive defaults for local development only.

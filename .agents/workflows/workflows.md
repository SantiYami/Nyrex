---
description: Nyrex Development
---

# Nyrex Development Workflows

These workflows should be strictly followed by any AI agent or developer contributing to this repo.

## Local Execution

- **Run Backing Services**: `docker compose -f infra/docker/docker-compose.yml up -d`
- **Run Backend API**: `cd services/api && cargo run` or `cargo watch -x run`
- **Run Frontend**: `cd apps/flutter && flutter run -d <platform>` targeting macOS/windows/linux for rapid iteration.

## PostgreSQL Migrations (Global)

- Handled solely via `sqlx-cli` in the Rust backend.
- Command to add: `sqlx migrate add <description>` inside `services/api`.
- Apply migrations: `sqlx migrate run`.
- When changes are made here, Flutter's `drift` definitions *must* be updated manually to mirror the backend schema, followed by `dart run build_runner build` in `apps/flutter`.

## Creating a new Module

1. Determine the domain entities across both Rust (`libs/domain`) and Flutter (`apps/flutter/lib/modules/<name>/domain`).
2. Construct the SQLx PostgreSQL migrations.
3. Construct the drift local DB schemas.
4. Integrate the offline-first logic locally using Riverpod providers.
5. Create the Axum endpoints in `/services/api/src/routes/<name>.rs`.
6. Hook actions to the Sync events background queue.

## PR and CI Checks

- `flutter analyze` must pass in the UI folder.
- `cargo clippy` and `cargo fmt --check` must pass in backend crates.

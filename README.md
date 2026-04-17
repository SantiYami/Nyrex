# Nyrex 🚀

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

> Swiss Army knife personal toolkit · Flutter + Rust · Local-first ·
> Horizontally scalable

Nyrex is a personal productivity platform designed to grow horizontally — each
new module plugs into a shared core without touching existing functionality. It
is not a SaaS product; it is a personal tool that you own, control, and extend.

## 🌟 Key Features

- **Local-only execution:** The primary source of truth is the local `drift`
  SQLite database across any device. Offline works perfectly.
- **Encrypted by default:** User data syncs asynchronously to the backend purely
  as AES-256-GCM ciphertexts. Your Keys never leave the device.
- **Cross-platform UI:** Universal codebase supporting Desktop, Mobile, and Web
  seamlessly via Flutter.
- **Blazing Backend:** Rust Axum & Tokio web server endpoints purely functioning
  for state syncing and heavy-lifting search integration.

## 📁 Monorepo Structure

- `/apps/flutter`: The main cross-platform application UI.
- `/services/api`: The Rust backend (Axum).
- `/services/search`: Meilisearch integration layer jobs.
- `/services/sync`: CRDT Event sync engine queue handlers.
- `/libs/*`: Shared Rust primitives (domain payloads, crypto layers).
- `/infra/docker`: Setup for self-hosted backend.
- `/docs/`: Long-form architectural guidelines and manifests.
- `/.agents/`: Workflows and rigid rules for AI LLM coding interactions.

## 🛠️ Quick Start

### Backend (Rust & Docker)

```bash
# Start required backing databases (Postgres, Meilisearch)
cd infra/docker && docker compose up -d

# Start the Axum API Server
cd services/api && cargo watch -x run
```

### Frontend (Flutter)

```bash
# Run local desktop build
cd apps/flutter && flutter run -d windows
```

> See the `docs/architecture_plan_v1.md` for our full roadmap and vision board!

## ⚖️ License

This project is licensed under the **CC BY-NC-SA 4.0** License.

ℹ️ **Licensing Note**: As the sole author, I reserve the right to change the
license for future versions of Nyrex. Existing versions will remain under their
original license. If you rely on a specific license, consider forking or pinning
to a specific version.

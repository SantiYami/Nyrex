# Nyrex 🚀

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Rust](https://img.shields.io/badge/Backend-Rust-black?logo=rust)](https://www.rust-lang.org/)
[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter)](https://flutter.dev/)

> **The Swiss Army knife for your digital life.**  
> A personal productivity platform built with **Flutter** and **Rust**. Local-first, E2E Encrypted, and designed for absolute data sovereignty.

---

## 🏗️ Architecture: The Nyrex Pillar

Nyrex is designed as a **Local-first** application. Your device is the absolute source of truth. The backend exists strictly as a high-performance **Sync & Search** target.

### 🛡️ Security by Design (SOTA)

We don't settle for "good enough". Nyrex implements state-of-the-art cryptographic primitives:

- **Identity & Auth**: **EdDSA (Ed25519)** asymmetric signing for JWTs. No shared secrets for verification.
- **Password Hashing**: **Argon2id** (OWASP recommended) for session verification.
- **Token Integrity**: **BLAKE3** for high-performance and secure entry fingerprinting.
- **Data Vault**: **AES-256-GCM** encryption (Local-only keys). Your data syncs as opaque ciphertext; the backend sees nothing.

---

## 📁 Monorepo Structure

### `services/` (The Cloud Layer)

- **`api/`**: Axum-based entry point. Identity management and sync routing.
- **`sync/`**: (In Progress) The Event Log and CRDT conflict resolution engine.
- **`search/`**: Meilisearch bridge for high-speed full-text search.

### `crates/` (Shared Logic)

- **`core/`**: Shared Domain Models, Errors, and Traits (The "Brain").
- **`crypto/`**: Reusable cryptographic pipelines (AES-GCM, KDF).
- **`store/`**: PostgreSQL engine using `sqlx` with offline-ready prepared queries.

### `apps/` (The Client)

- **`flutter/`**: Universal UI for Mobile and Desktop.

---

## 🛠️ Quick Start

### 1. Backend Environment

Copy the example environment file and fill in your secrets:

```bash
cp .env.example .env
```

> **Note:** For EdDSA, you need an Ed25519 key pair in Base64 format. See `.env.example` for details.

### 2. Infrastructure (Docker)

Launch the database and required services:

```bash
cd infra/docker
docker compose up -d
```

### 3. Run the API

```bash
cd services/api
cargo run
```

---

## 📜 Principles

1. **Offline-First**: Data must load instantly from local SQLite. No loading spinners for local data.
2. **Modular**: Every feature is a pluggable module.
3. **Rust-Powered**: Heavy lifting and security are handled by type-safe, memory-safe Rust code.

---

## ⚖️ License

Licensed under **CC BY-NC-SA 4.0**. See [LICENSE](LICENSE) for details.

> [!NOTE]
> **Licensing Transparency**: As the sole author, I reserve the right to change the license for future versions or commercialize specific modules. Existing versions remain under their original license. This ensures Nyrex can evolve while protecting early contributions and data sovereignty.

# Contributing to Nyrex

Thank you for your interest in contributing to Nyrex! This document outlines the process for contributing code, documentation, or ideas to this project.

## 📜 License

Nyrex is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)** license.

By contributing to this project, you agree that:

- Your contributions will be licensed under the same CC BY-NC-SA 4.0 license.
- You have the right to license your contributions under these terms.
- You grant the project maintainer(s) permission to use, modify, and distribute your contributions under this license.

> ⚠️ **Non-Commercial Use Only**: Nyrex is intended for personal, educational, and non-commercial use. Contributions that enable or encourage commercial exploitation may not be accepted.

## 🚀 Getting Started

### Prerequisites

- Rust toolchain (latest stable) — [rustup.rs](https://rustup.rs)
- Flutter SDK (latest stable) — [flutter.dev](https://flutter.dev)
- Docker & Docker Compose (for local backend testing)

### Setup

```bash
# Clone the repository
git clone https://github.com/SantiYami/nyrex.git
cd nyrex

# Set up Rust backend
cd services/api
cargo build

# Set up Flutter app
cd ../../apps/flutter
flutter pub get
flutter run
```

## 🧭 How to Contribute

### 1. Check Existing Issues

Before starting work, browse open issues and the roadmap to avoid duplicate effort.

### 2. Create a Feature Branch

```bash
git checkout -b feature/my-module
```

### 3. Follow Code Standards

#### Rust

- Every file MUST contain the SPDX license identifier at the top:
  `// SPDX-License-Identifier: CC-BY-NC-SA-4.0`
- Run `cargo clippy --all-targets --all-features -- -D warnings` before
  committing.
- Add unit tests for new logic.
- Use `tracing` for logging, not `println!`.

#### Flutter/Dart

- Every file MUST contain the SPDX license identifier at the top:
  `// SPDX-License-Identifier: CC-BY-NC-SA-4.0`
- Run `flutter analyze` and `dart format .` before committing.
- Add components/widget tests for new UI logic.
- Use `Riverpod` for state management; avoid `setState` for complex logic.

#### General

- Keep commits small and focused.
- Write clear commit messages (imperative mood: "Add X", "Fix Y").
- Update documentation if you change behavior.

### 4. Test Locally

- Ensure the app builds and runs on at least one platform (mobile or desktop).
- Test sync flow with the local Docker Compose setup.
- Verify encryption/decryption works end-to-end for vault entries.

### 5. Submit a Pull Request

- Push your branch and open a PR against `main`.
- Fill out the PR template with:
  - What problem this solves
  - How to test the changes
  - Any breaking changes or migration steps
- Link to related issues using `Closes #123` syntax.

If your contribution touches encryption, authentication, or key management:

- **Do not implement custom crypto algorithms.**
- Use established crates: `argon2`, `aes-gcm`, `zeroize`.
- Ensure keys are zeroed after use (`zeroize::Zeroize`).

## 🧩 Adding a New Module

Nyrex grows via modular plugins. Before proposing a new module:
✅ Ask yourself:

- Will I use this at least once per week?
- Does it integrate with existing data (notes, tasks, search)?
- Can it start simple and evolve incrementally?
- Does it belong in Nyrex, or is a standalone tool better?

If yes to all:

- Create a new folder under `apps/flutter/lib/modules/your_module/`
- Follow the module structure: `data/`, `domain/`, `presentation/`
- Document the module's purpose and API in `docs/modules/your_module.md`

## 🐛 Reporting Bugs

Use the Bug Report template and include steps to reproduce, expected vs. actual behavior, and logs/screenshots.

# Nyrex v1.0 — Module: Vault (Stage 2)

> Local-encryption credential manager. AES-256-GCM. Master password never leaves device.

---

## Module Path

`apps/flutter/lib/modules/vault/` — **new module** (the old `vault/` is renamed to `notes/` in Stage 0).

```
modules/vault/
├── data/
│   ├── datasources/
│   │   └── vault_local_datasource.dart   # drift queries
│   ├── models/
│   │   └── vault_entry_model.dart        # DB model + JSON
│   └── repositories/
│       └── vault_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── vault_entry.dart              # Freezed domain model
│   └── repositories/
│       └── vault_repository.dart         # Abstract interface
└── presentation/
    ├── providers/
    │   ├── vault_provider.dart           # Riverpod AsyncNotifier
    │   └── vault_unlock_provider.dart    # Lock/unlock state
    ├── screens/
    │   ├── vault_list_screen.dart
    │   ├── vault_entry_detail_screen.dart
    │   ├── vault_unlock_screen.dart
    │   └── vault_create_screen.dart      # Creation wizard
    └── widgets/
        ├── vault_entry_tile.dart         # Favicon + hidden creds + copy
        ├── vault_category_filter.dart
        └── vault_password_field.dart     # Reveal/copy toggle
```

---

## Encryption Model

```
Master password → argon2id KDF (salt stored locally)
    → 256-bit vault key (in memory + secure enclave, never on disk)
    → AES-256-GCM encrypt/decrypt per entry
    → ciphertext + nonce stored in SQLite / synced to backend
```

Backend **never** sees plaintext passwords or keys.

---

## User Stories

### S2.1 — Vault Unlock Screen

> *As a user, I want to set and enter a master password to unlock my vault.*

- First use: set master password + confirmation.
- Subsequent: enter password → derive key → unlock.
- Biometric support on mobile (fingerprint/face).
- Auto-lock on app background or configurable timeout.
- Error state: wrong password with attempt counter.
- Reset state: warning that vault data is irrecoverable.

**Acceptance:** Vault inaccessible without correct master password.

### S2.2 — Vault Entry CRUD

> *As a user, I want to create, view, edit, and delete credential entries.*

**Entry fields:** title, username, password, URL, notes, category, tags.

- **List view:** favicon (from URL), title, username (shown), password (hidden dots), copy buttons.
- **Detail view:** all fields with reveal/copy toggles. Edit inline.
- **Creation wizard:** 3 entry types:
  - Standard (username + password + URL)
  - SSO (provider + email + linked service)
  - Email account (email + password + IMAP/SMTP)
- **Delete:** soft-delete with undo toast (30s window).

All fields encrypted with vault key before SQLite write.

**Acceptance:** Entries encrypt on save, decrypt on read. Copy-to-clipboard works.

### S2.3 — Categories & Tags

> *As a user, I want to organize entries with categories and tags.*

- Predefined categories: Social, Finance, Work, Email, Dev, Other.
- Custom tags (user-created, pill badges).
- Sidebar filter by category and/or tag.
- Search within vault entries (searches decrypted titles only, in-memory).

**Acceptance:** Tags persist. Filtering updates entry list reactively.

### S2.4 — Master Password Change

> *As a user, I want to change my master password, re-encrypting all entries.*

- Verify old password → derive new key → re-encrypt all entries in SQLite transaction.
- Failure rolls back entire transaction.
- Success: update secure enclave, clear old key from memory.

**Acceptance:** All entries accessible after password change. Old password no longer works.

---

## Dependencies

- `cryptography` + `cryptography_flutter` (already in pubspec)
- `flutter_secure_storage` (to add — for master key in secure enclave)

*Last updated: May 2026*

# Nyrex — Backend: Encryption Model

> AES-256-GCM client-side encryption. Argon2id key derivation. Backend never sees plaintext.

## Key Derivation

```
User master password
    → argon2id KDF (salt stored locally in secure enclave)
    → 256-bit vault key
    → Stored in memory (Rust SecretVec / Dart secure storage)
    → NEVER written to disk in plaintext
```

## Encrypt/Decrypt Flow

```
Encrypt: plaintext entry → AES-256-GCM(vault_key) → ciphertext + 12-byte nonce → store in SQLite / sync
Decrypt: ciphertext + nonce → AES-256-GCM(vault_key) → plaintext entry → display in UI
```

## Rust Crypto Crate (`crates/crypto/`)

```toml
[dependencies]
argon2   = "0.5"
aes-gcm  = "0.10"
rand     = "0.8"
zeroize  = "1.7"
```

## Rules

- **No custom crypto.** Use only `argon2`, `aes-gcm`, `zeroize`.
- **Keys zeroed after use** via `zeroize::Zeroize`.
- **No hardcoded secrets.** Fail fast with `expect`/`panic` if env vars missing.
- **Backend NEVER sees plaintext** passwords or vault entries.
- **Master password change:** verify old → derive new key → re-encrypt all entries in transaction → update secure enclave → clear old key.
- **Lost master password = irrecoverable vault.** By design.

## S3 Backup Encryption

SQLite snapshot → encrypt with vault key (AES-256-GCM) → upload to S3. Restore reverses the process.

*Last updated: May 2026*

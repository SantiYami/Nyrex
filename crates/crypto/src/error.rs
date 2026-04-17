// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use thiserror::Error;

#[derive(Debug, Error)]
pub enum CryptoError {
    #[error("Encryption failed")]
    EncryptionError,

    #[error("Decryption failed (invalid key or corrupted data)")]
    DecryptionError,

    #[error("Key derivation failed: {0}")]
    KdfError(String),

    #[error("Invalid key length (expected {expected}, got {actual})")]
    InvalidKeyLength { expected: usize, actual: usize },
}

pub type Result<T> = std::result::Result<T, CryptoError>;

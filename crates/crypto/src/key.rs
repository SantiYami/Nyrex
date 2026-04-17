// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use crate::error::{CryptoError, Result};
use zeroize::ZeroizeOnDrop;

/// A secure wrapper around the 256-bit (32 byte) AES-GCM vault key.
/// Using ZeroizeOnDrop ensures that when this key goes out of scope,
/// its memory is overwritten with zeroes to protect against memory scraping.
#[derive(Clone, ZeroizeOnDrop)]
pub struct VaultKey {
    inner: [u8; 32],
}

impl VaultKey {
    /// Creates a new VaultKey from a 32-byte slice.
    pub fn new(bytes: &[u8]) -> Result<Self> {
        if bytes.len() != 32 {
            return Err(CryptoError::InvalidKeyLength {
                expected: 32,
                actual: bytes.len(),
            });
        }
        let mut inner = [0u8; 32];
        inner.copy_from_slice(bytes);
        Ok(Self { inner })
    }

    /// Access the underlying bytes.
    pub fn as_bytes(&self) -> &[u8; 32] {
        &self.inner
    }
}

// Do not implement standard Debug or Display for VaultKey to avoid accidental logging.
impl std::fmt::Debug for VaultKey {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "VaultKey([REDACTED])")
    }
}

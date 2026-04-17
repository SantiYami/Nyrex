// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use crate::error::{CryptoError, Result};
use crate::key::VaultKey;
use argon2::{Argon2, Algorithm, Params, Version};
use argon2::password_hash::SaltString;

/// Derives a 32-byte VaultKey from a master password and a salt using Argon2id.
///
/// In Nyrex, the salt is generated once per user and stored on the device.
/// The backend does not perform this derivation in typical flows, but this crate
/// shares logic that could be compiled to WASM or used in administrative recovery.
pub fn derive_key(password: &str, salt: &str) -> Result<VaultKey> {
    let salt_string = SaltString::from_b64(salt)
        .map_err(|e| CryptoError::KdfError(e.to_string()))?;

    // We configure Argon2id with OWASP recommendations or reasonable defaults 
    // for local derivation (e.g. 19 MiB memory, 2 iterations, 1 degree of parallelism minimum)
    let params = Params::new(19456, 2, 1, Some(32))
        .map_err(|e| CryptoError::KdfError(e.to_string()))?;

    let argon2 = Argon2::new(Algorithm::Argon2id, Version::V0x13, params);

    let mut key_bytes = [0u8; 32];
    argon2
        .hash_password_into(password.as_bytes(), salt_string.as_str().as_bytes(), &mut key_bytes)
        .map_err(|e| CryptoError::KdfError(e.to_string()))?;

    VaultKey::new(&key_bytes)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_derive_key_determinism() {
        let pw = "hunter2";
        // A valid B64 salt without padding (PHC string format standard)
        let salt = "c29tZXNhbHRzdHJpbmcxMj"; 
        
        let key1 = derive_key(pw, salt).unwrap();
        let key2 = derive_key(pw, salt).unwrap();
        
        assert_eq!(key1.as_bytes(), key2.as_bytes());
        
        let key3 = derive_key("hunter3", salt).unwrap();
        assert_ne!(key1.as_bytes(), key3.as_bytes());
    }
}

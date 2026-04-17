// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use crate::error::{CryptoError, Result};
use crate::key::VaultKey;
use aes_gcm::{
    aead::{Aead, AeadCore, KeyInit, OsRng},
    Aes256Gcm, Nonce,
};

/// Encrypts plaintext data using AES-256-GCM and a securely generated nonce.
/// Returns a tuple of (ciphertext, nonce).
pub fn encrypt_entry(plaintext: &[u8], key: &VaultKey) -> Result<(Vec<u8>, Vec<u8>)> {
    let cipher = Aes256Gcm::new_from_slice(key.as_bytes())
        .map_err(|_| CryptoError::EncryptionError)?;
    
    // Generate a random 96-bit (12-byte) nonce
    let nonce = Aes256Gcm::generate_nonce(&mut OsRng);
    
    let ciphertext = cipher
        .encrypt(&nonce, plaintext)
        .map_err(|_| CryptoError::EncryptionError)?;

    Ok((ciphertext, nonce.to_vec()))
}

/// Decrypts AES-256-GCM ciphertext using the provided nonce and key.
pub fn decrypt_entry(ciphertext: &[u8], nonce_bytes: &[u8], key: &VaultKey) -> Result<Vec<u8>> {
    let cipher = Aes256Gcm::new_from_slice(key.as_bytes())
        .map_err(|_| CryptoError::DecryptionError)?;
    
    let nonce = Nonce::from_exact_iter(nonce_bytes.iter().copied())
        .ok_or(CryptoError::DecryptionError)?;

    cipher
        .decrypt(&nonce, ciphertext)
        .map_err(|_| CryptoError::DecryptionError)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_round_trip_encryption() {
        // Create an arbitrary 32 byte key
        let mut key_bytes = [0u8; 32];
        key_bytes[0] = 42;
        let key = VaultKey::new(&key_bytes).unwrap();
        
        let secret_message = b"Top secret vault password";
        
        let (ciphertext, nonce) = encrypt_entry(secret_message, &key).unwrap();
        
        // Assert it actually got encrypted
        assert_ne!(ciphertext, secret_message);
        
        // Attempt decryption with correct key/nonce
        let decrypted = decrypt_entry(&ciphertext, &nonce, &key).unwrap();
        assert_eq!(decrypted, secret_message);
    }

    #[test]
    fn test_decryption_fails_with_bad_key() {
        let key1 = VaultKey::new(&[1u8; 32]).unwrap();
        let key2 = VaultKey::new(&[2u8; 32]).unwrap();
        
        let message = b"sensitive info";
        
        let (ciphertext, nonce) = encrypt_entry(message, &key1).unwrap();
        
        // Try to decrypt with key2
        let result = decrypt_entry(&ciphertext, &nonce, &key2);
        assert!(result.is_err());
    }
}

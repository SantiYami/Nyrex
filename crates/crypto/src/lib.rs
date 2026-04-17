// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

pub mod cipher;
pub mod error;
pub mod kdf;
pub mod key;

pub use cipher::{decrypt_entry, encrypt_entry};
pub use error::CryptoError;
pub use kdf::derive_key;
pub use key::VaultKey;

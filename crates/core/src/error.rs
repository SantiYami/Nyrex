// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use thiserror::Error;

#[derive(Debug, Error)]
pub enum CoreError {
    #[error("Not found: {0}")]
    NotFound(String),

    #[error("Conflict: {0}")]
    Conflict(String),

    #[error("Database error: {0}")]
    Database(String),

    #[error("Serialization error: {0}")]
    Serialization(#[from] serde_json::Error),
    
    #[error("Internal domain error: {0}")]
    Internal(String),
}

pub type Result<T> = std::result::Result<T, CoreError>;

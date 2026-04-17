// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use sqlx::FromRow;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, FromRow)]
pub struct User {
    pub id: Uuid,
    pub email: String,
    pub display_name: Option<String>,
    pub sso_provider: Option<String>,
    pub sso_sub: Option<String>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, FromRow)]
pub struct Note {
    pub id: Uuid,
    pub user_id: Uuid,
    pub title: String,
    pub content: String,
    pub format: String,
    pub tags: Vec<String>,
    pub is_encrypted: bool,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub deleted_at: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, FromRow)]
pub struct VaultEntry {
    pub id: Uuid,
    pub user_id: Uuid,
    pub ciphertext: Vec<u8>,
    pub nonce: Vec<u8>,
    pub hint: Option<String>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub deleted_at: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, FromRow)]
pub struct SyncEvent {
    pub id: i64,
    pub user_id: Uuid,
    pub entity_type: String,
    pub entity_id: Uuid,
    pub operation: String, // 'create', 'update', 'delete'
    pub payload: Option<serde_json::Value>,
    pub client_id: String,
    pub created_at: DateTime<Utc>,
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use uuid::Uuid;

    #[test]
    fn test_note_serialization() {
        let note = Note {
            id: Uuid::new_v4(),
            user_id: Uuid::new_v4(),
            title: "Test Note".to_string(),
            content: "Hello world".to_string(),
            format: "markdown".to_string(),
            tags: vec!["test".to_string()],
            is_encrypted: false,
            created_at: Utc::now(),
            updated_at: Utc::now(),
            deleted_at: None,
        };

        let serialized = serde_json::to_string(&note).unwrap();
        let deserialized: Note = serde_json::from_str(&serialized).unwrap();

        assert_eq!(note, deserialized);
    }
}

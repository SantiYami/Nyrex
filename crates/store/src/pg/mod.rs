// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use nyrex_core::error::{CoreError, Result};
use nyrex_core::models::Note;
use nyrex_core::traits::NoteStore;
use sqlx::PgPool;
use uuid::Uuid;

pub mod auth;
pub use auth::PgAuthStore;

pub struct PgNyrexStore {
    pub pool: PgPool,
}

impl PgNyrexStore {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

impl NoteStore for PgNyrexStore {
    async fn get_note(&self, user_id: Uuid, note_id: Uuid) -> Result<Option<Note>> {
        sqlx::query_as::<_, Note>(
            "SELECT * FROM notes WHERE user_id = $1 AND id = $2 AND deleted_at IS NULL"
        )
        .bind(user_id)
        .bind(note_id)
        .fetch_optional(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn list_notes(&self, user_id: Uuid) -> Result<Vec<Note>> {
        sqlx::query_as::<_, Note>(
            "SELECT * FROM notes WHERE user_id = $1 AND deleted_at IS NULL ORDER BY updated_at DESC"
        )
        .bind(user_id)
        .fetch_all(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn create_note(&self, note: Note) -> Result<Note> {
        sqlx::query_as::<_, Note>(
            r#"
            INSERT INTO notes (id, user_id, title_cipher, content_cipher, nonce, version, format, tags, created_at, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
            RETURNING *
            "#
        )
        .bind(note.id)
        .bind(note.user_id)
        .bind(note.title_cipher.clone())
        .bind(note.content_cipher.clone())
        .bind(note.nonce.clone())
        .bind(note.version)
        .bind(note.format.clone())
        .bind(note.tags.clone())
        .bind(note.created_at)
        .bind(note.updated_at)
        .fetch_one(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn update_note(&self, note: Note) -> Result<Note> {
        sqlx::query_as::<_, Note>(
            r#"
            UPDATE notes
            SET title_cipher = $1, content_cipher = $2, nonce = $3, version = $4, format = $5, tags = $6, updated_at = $7
            WHERE id = $8 AND user_id = $9
            RETURNING *
            "#
        )
        .bind(note.title_cipher.clone())
        .bind(note.content_cipher.clone())
        .bind(note.nonce.clone())
        .bind(note.version)
        .bind(note.format.clone())
        .bind(note.tags.clone())
        .bind(chrono::Utc::now())
        .bind(note.id)
        .bind(note.user_id)
        .fetch_one(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn delete_note(&self, user_id: Uuid, note_id: Uuid) -> Result<()> {
        sqlx::query(
            "UPDATE notes SET deleted_at = NOW() WHERE id = $1 AND user_id = $2"
        )
        .bind(note_id)
        .bind(user_id)
        .execute(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))?;
        Ok(())
    }
}

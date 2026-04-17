// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use nyrex_core::error::{CoreError, Result};
use nyrex_core::models::Note;
use nyrex_core::traits::NoteStore;
use sqlx::PgPool;
use uuid::Uuid;

pub struct PgNyrexStore {
    pool: PgPool,
}

impl PgNyrexStore {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

impl NoteStore for PgNyrexStore {
    async fn get_note(&self, user_id: Uuid, note_id: Uuid) -> Result<Option<Note>> {
        sqlx::query_as!(
            Note,
            "SELECT * FROM notes WHERE user_id = $1 AND id = $2 AND deleted_at IS NULL",
            user_id,
            note_id
        )
        .fetch_optional(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn list_notes(&self, user_id: Uuid) -> Result<Vec<Note>> {
        sqlx::query_as!(
            Note,
            "SELECT * FROM notes WHERE user_id = $1 AND deleted_at IS NULL ORDER BY updated_at DESC",
            user_id
        )
        .fetch_all(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn create_note(&self, note: Note) -> Result<Note> {
        sqlx::query_as!(
            Note,
            r#"
            INSERT INTO notes (id, user_id, title, content, format, tags, is_encrypted, created_at, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
            RETURNING *
            "#,
            note.id,
            note.user_id,
            note.title,
            note.content,
            note.format,
            &note.tags,
            note.is_encrypted,
            note.created_at,
            note.updated_at
        )
        .fetch_one(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn update_note(&self, note: Note) -> Result<Note> {
        sqlx::query_as!(
            Note,
            r#"
            UPDATE notes
            SET title = $1, content = $2, format = $3, tags = $4, is_encrypted = $5, updated_at = $6
            WHERE id = $7 AND user_id = $8
            RETURNING *
            "#,
            note.title,
            note.content,
            note.format,
            &note.tags,
            note.is_encrypted,
            chrono::Utc::now(),
            note.id,
            note.user_id
        )
        .fetch_one(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    async fn delete_note(&self, user_id: Uuid, note_id: Uuid) -> Result<()> {
        sqlx::query(
            "UPDATE notes SET deleted_at = NOW() WHERE id = $1 AND user_id = $2",
        )
        .bind(note_id)
        .bind(user_id)
        .execute(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))?;
        Ok(())
    }
}

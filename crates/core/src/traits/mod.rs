// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use crate::error::Result;
use crate::models::{Note, SyncEvent, VaultEntry};
use async_trait::async_trait;
use uuid::Uuid;

#[async_trait]
pub trait NoteStore: Send + Sync {
    async fn get_note(&self, user_id: Uuid, note_id: Uuid) -> Result<Option<Note>>;
    async fn list_notes(&self, user_id: Uuid) -> Result<Vec<Note>>;
    async fn create_note(&self, note: Note) -> Result<Note>;
    async fn update_note(&self, note: Note) -> Result<Note>;
    async fn delete_note(&self, user_id: Uuid, note_id: Uuid) -> Result<()>;
}

#[async_trait]
pub trait VaultStore: Send + Sync {
    async fn get_entry(&self, user_id: Uuid, entry_id: Uuid) -> Result<Option<VaultEntry>>;
    async fn list_entries(&self, user_id: Uuid) -> Result<Vec<VaultEntry>>;
    async fn create_entry(&self, entry: VaultEntry) -> Result<VaultEntry>;
    async fn update_entry(&self, entry: VaultEntry) -> Result<VaultEntry>;
    async fn delete_entry(&self, user_id: Uuid, entry_id: Uuid) -> Result<()>;
}

#[async_trait]
pub trait SyncEngine: Send + Sync {
    async fn get_events_since(&self, user_id: Uuid, client_id: &str, since_id: i64) -> Result<Vec<SyncEvent>>;
    async fn append_events(&self, events: Vec<SyncEvent>) -> Result<()>;
}

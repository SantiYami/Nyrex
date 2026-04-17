// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use crate::error::Result;
use crate::models::{Note, SyncEvent, VaultEntry};
use uuid::Uuid;
pub trait NoteStore: Send + Sync {
    fn get_note(
        &self,
        user_id: Uuid,
        note_id: Uuid,
    ) -> impl std::future::Future<Output = Result<Option<Note>>> + Send;
    fn list_notes(&self, user_id: Uuid) -> impl std::future::Future<Output = Result<Vec<Note>>> + Send;
    fn create_note(&self, note: Note) -> impl std::future::Future<Output = Result<Note>> + Send;
    fn update_note(&self, note: Note) -> impl std::future::Future<Output = Result<Note>> + Send;
    fn delete_note(
        &self,
        user_id: Uuid,
        note_id: Uuid,
    ) -> impl std::future::Future<Output = Result<()>> + Send;
}

pub trait VaultStore: Send + Sync {
    fn get_entry(
        &self,
        user_id: Uuid,
        entry_id: Uuid,
    ) -> impl std::future::Future<Output = Result<Option<VaultEntry>>> + Send;
    fn list_entries(
        &self,
        user_id: Uuid,
    ) -> impl std::future::Future<Output = Result<Vec<VaultEntry>>> + Send;
    fn create_entry(
        &self,
        entry: VaultEntry,
    ) -> impl std::future::Future<Output = Result<VaultEntry>> + Send;
    fn update_entry(
        &self,
        entry: VaultEntry,
    ) -> impl std::future::Future<Output = Result<VaultEntry>> + Send;
    fn delete_entry(
        &self,
        user_id: Uuid,
        entry_id: Uuid,
    ) -> impl std::future::Future<Output = Result<()>> + Send;
}

pub trait SyncEngine: Send + Sync {
    fn get_events_since(
        &self,
        user_id: Uuid,
        client_id: &str,
        since_id: i64,
    ) -> impl std::future::Future<Output = Result<Vec<SyncEvent>>> + Send;
    fn append_events(
        &self,
        events: Vec<SyncEvent>,
    ) -> impl std::future::Future<Output = Result<()>> + Send;
}

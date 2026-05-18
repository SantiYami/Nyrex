// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use nyrex_core::models::Note;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub enum SyncResult<T> {
    Success(T),
    Conflict { server_version: T },
    Error(String),
}

/// The SyncEngine is responsible for reconciling changes between clients and the server.
/// In Nyrex, we use Optimistic Locking based on a version counter.
pub struct SyncEngine;

impl SyncEngine {
    /// Reconciles a single note update.
    /// - If versions match: returns Success with the updated note.
    /// - If versions mismatch: returns Conflict with the current server version.
    pub fn reconcile_note(
        client_note: Note,
        server_note: Option<Note>,
    ) -> SyncResult<Note> {
        match server_note {
            None => {
                // New note from client, always success
                SyncResult::Success(client_note)
            }
            Some(server) => {
                if client_note.version == server.version {
                    // Optimized: versions match, we can perform the update
                    let mut updated = client_note;
                    updated.version += 1; // Increment version on server
                    SyncResult::Success(updated)
                } else {
                    // Conflict! Someone else pushed a change first
                    SyncResult::Conflict { server_version: server }
                }
            }
        }
    }
}

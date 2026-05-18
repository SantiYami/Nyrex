// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use axum::extract::{State, Json};
use nyrex_core::models::Note;
use nyrex_sync::{SyncEngine, SyncResult};

use uuid::Uuid;




pub async fn upload_vault_entry(
    State(state): State<crate::AppState>,
    axum::Extension(session): axum::Extension<crate::middleware::auth::AuthUser>,
    Json(vault_entry): Json<nyrex_core::models::VaultEntry>,
) -> Json<nyrex_sync::SyncResult<Uuid>> {
    // Ownership check
    if vault_entry.user_id != session.user_id {
        return Json(nyrex_sync::SyncResult::Error("Unauthorized".to_string()));
    }

    let db = &state.db.pool;
    let res = sqlx::query(
        r#"
        INSERT INTO vault_entries (id, note_id, user_id, file_cipher, nonce, mime_type, file_size)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        "#
    )
    .bind(vault_entry.id)
    .bind(vault_entry.note_id)
    .bind(vault_entry.user_id)
    .bind(&vault_entry.file_cipher)
    .bind(&vault_entry.nonce)
    .bind(&vault_entry.mime_type)
    .bind(vault_entry.file_size)
    .execute(db)
    .await;

    match res {
        Ok(_) => Json(nyrex_sync::SyncResult::Success(vault_entry.id)),
        Err(e) => Json(nyrex_sync::SyncResult::Error(e.to_string())),
    }
}

pub async fn sync_notes(
    State(state): State<crate::AppState>,
    axum::Extension(session): axum::Extension<crate::middleware::auth::AuthUser>,
    Json(client_notes): Json<Vec<Note>>,
) -> Json<Vec<SyncResult<Note>>> {
    let mut results = Vec::new();
    let db = &state.db.pool;

    for client_note in client_notes {
        // Enforce user ownership
        if client_note.user_id != session.user_id {
            results.push(SyncResult::Error("Unauthorized note ownership".to_string()));
            continue;
        }

        // Fetch current server state
        let server_note = sqlx::query_as::<_, Note>(
            "SELECT * FROM notes WHERE id = $1 AND user_id = $2"
        )
        .bind(client_note.id)
        .bind(session.user_id)
        .fetch_optional(db)
        .await
        .unwrap_or(None);

        let reconciliation = SyncEngine::reconcile_note(client_note, server_note);

        match reconciliation {
            SyncResult::Success(updated_note) => {
                // Upsert into DB
                let res = sqlx::query(
                    r#"
                    INSERT INTO notes (id, user_id, title_cipher, content_cipher, nonce, version, updated_at)
                    VALUES ($1, $2, $3, $4, $5, $6, NOW())
                    ON CONFLICT (id) DO UPDATE SET
                        title_cipher = EXCLUDED.title_cipher,
                        content_cipher = EXCLUDED.content_cipher,
                        nonce = EXCLUDED.nonce,
                        version = EXCLUDED.version,
                        updated_at = NOW()
                    "#
                )
                .bind(updated_note.id)
                .bind(updated_note.user_id)
                .bind(&updated_note.title_cipher)
                .bind(&updated_note.content_cipher)
                .bind(&updated_note.nonce)
                .bind(updated_note.version)
                .execute(db)
                .await;

                if res.is_ok() {
                    results.push(SyncResult::Success(updated_note));
                } else {
                    results.push(SyncResult::Error("Database update failed".to_string()));
                }
            }
            SyncResult::Conflict { server_version } => {
                results.push(SyncResult::Conflict { server_version });
            }
            SyncResult::Error(e) => {
                results.push(SyncResult::Error(e));
            }
        }
    }

    Json(results)
}

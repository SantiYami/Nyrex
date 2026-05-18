-- SPDX-License-Identifier: CC-BY-NC-SA-4.0
-- Copyright (c) 2026 SantiYami

-- Upgrade notes to support encrypted blobs and optimistic locking (versioning)
ALTER TABLE notes 
    DROP COLUMN IF EXISTS title,
    DROP COLUMN IF EXISTS content,
    ADD COLUMN title_cipher BYTEA NOT NULL,
    ADD COLUMN content_cipher BYTEA NOT NULL,
    ADD COLUMN nonce BYTEA NOT NULL,
    ADD COLUMN version INT NOT NULL DEFAULT 1;

-- Table for encrypted file attachments (images, pdf, etc)
CREATE TABLE IF NOT EXISTS vault_entries (
    id UUID PRIMARY KEY,
    note_id UUID NOT NULL REFERENCES notes(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    file_cipher BYTEA NOT NULL,
    nonce BYTEA NOT NULL,
    mime_type VARCHAR(100),
    file_size INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for faster lookups of note attachments
CREATE INDEX IF NOT EXISTS idx_vault_entries_note_id ON vault_entries(note_id);

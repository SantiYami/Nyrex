-- SPDX-License-Identifier: CC-BY-NC-SA-4.0
-- Copyright (c) 2026 SantiYami

-- Add password_hash to users for server-side login verification
ALTER TABLE users ADD COLUMN password_hash TEXT NOT NULL DEFAULT '';

-- Refresh tokens for secure session management
CREATE TABLE IF NOT EXISTS refresh_tokens (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash TEXT NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user_id ON refresh_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_token_hash ON refresh_tokens(token_hash);

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use nyrex_core::error::{CoreError, Result};
use nyrex_core::models::{RefreshToken, User};
use sqlx::PgPool;
use uuid::Uuid;

pub struct PgAuthStore {
    pool: PgPool,
}

impl PgAuthStore {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }

    /// Create a new user with a pre-hashed password.
    pub async fn create_user(
        &self,
        id: Uuid,
        email: &str,
        password_hash: &str,
        display_name: Option<&str>,
    ) -> Result<User> {
        sqlx::query_as!(
            User,
            r#"
            INSERT INTO users (id, email, password_hash, display_name, created_at, updated_at)
            VALUES ($1, $2, $3, $4, NOW(), NOW())
            RETURNING *
            "#,
            id,
            email,
            password_hash,
            display_name,
        )
        .fetch_one(&self.pool)
        .await
        .map_err(|e| {
            if e.to_string().contains("duplicate key") {
                CoreError::Conflict(format!("User with email '{email}' already exists"))
            } else {
                CoreError::Database(e.to_string())
            }
        })
    }

    /// Find a user by email address.
    pub async fn get_user_by_email(&self, email: &str) -> Result<Option<User>> {
        sqlx::query_as!(
            User,
            "SELECT * FROM users WHERE email = $1",
            email,
        )
        .fetch_optional(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    /// Store a new refresh token.
    pub async fn store_refresh_token(&self, token: &RefreshToken) -> Result<()> {
        sqlx::query!(
            r#"
            INSERT INTO refresh_tokens (id, user_id, token_hash, expires_at, revoked, created_at)
            VALUES ($1, $2, $3, $4, $5, $6)
            "#,
            token.id,
            token.user_id,
            token.token_hash,
            token.expires_at,
            token.revoked,
            token.created_at,
        )
        .execute(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))?;
        Ok(())
    }

    /// Find a valid (non-revoked, non-expired) refresh token by its hash.
    pub async fn get_valid_refresh_token(&self, token_hash: &str) -> Result<Option<RefreshToken>> {
        sqlx::query_as!(
            RefreshToken,
            r#"
            SELECT * FROM refresh_tokens
            WHERE token_hash = $1 AND revoked = false AND expires_at > NOW()
            "#,
            token_hash,
        )
        .fetch_optional(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))
    }

    /// Revoke a specific refresh token.
    pub async fn revoke_refresh_token(&self, token_id: Uuid) -> Result<()> {
        sqlx::query!(
            "UPDATE refresh_tokens SET revoked = true WHERE id = $1",
            token_id,
        )
        .execute(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))?;
        Ok(())
    }

    /// Revoke all refresh tokens for a user (logout everywhere).
    pub async fn revoke_all_user_tokens(&self, user_id: Uuid) -> Result<()> {
        sqlx::query!(
            "UPDATE refresh_tokens SET revoked = true WHERE user_id = $1",
            user_id,
        )
        .execute(&self.pool)
        .await
        .map_err(|e| CoreError::Database(e.to_string()))?;
        Ok(())
    }
}

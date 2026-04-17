// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use axum::{extract::State, http::StatusCode, response::IntoResponse, Json};
use chrono::{Duration, Utc};
use nyrex_core::models::{
    AuthResponse, LoginRequest, RefreshRequest, RefreshToken, RegisterRequest, TokenClaims,
};
use uuid::Uuid;

use crate::auth_utils::{hash_password, hash_token, verify_password};
use crate::jwt;
use crate::AppState;

/// POST /auth/register
pub async fn register(
    State(state): State<AppState>,
    Json(body): Json<RegisterRequest>,
) -> Result<impl IntoResponse, (StatusCode, Json<serde_json::Value>)> {
    // Check if user already exists
    let existing = state.auth_store.get_user_by_email(&body.email).await;
    if let Ok(Some(_)) = existing {
        return Err((
            StatusCode::CONFLICT,
            Json(serde_json::json!({ "error": "Email already registered" })),
        ));
    }

    // Hash password with Argon2
    let password_hash = hash_password(&body.password).map_err(|e| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(serde_json::json!({ "error": e.to_string() })),
        )
    })?;

    let user_id = Uuid::new_v4();
    let user = state
        .auth_store
        .create_user(user_id, &body.email, &password_hash, body.display_name.as_deref())
        .await
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(serde_json::json!({ "error": e.to_string() })),
            )
        })?;

    // Generate token pair
    let auth_response = generate_token_pair(&state, user.id).await?;

    Ok((StatusCode::CREATED, Json(auth_response)))
}

/// POST /auth/login
pub async fn login(
    State(state): State<AppState>,
    Json(body): Json<LoginRequest>,
) -> Result<impl IntoResponse, (StatusCode, Json<serde_json::Value>)> {
    let user = state
        .auth_store
        .get_user_by_email(&body.email)
        .await
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(serde_json::json!({ "error": e.to_string() })),
            )
        })?
        .ok_or_else(|| {
            (
                StatusCode::UNAUTHORIZED,
                Json(serde_json::json!({ "error": "Invalid email or password" })),
            )
        })?;

    // Verify password
    if !verify_password(&body.password, &user.password_hash).map_err(|e| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(serde_json::json!({ "error": e.to_string() })),
        )
    })? {
        return Err((
            StatusCode::UNAUTHORIZED,
            Json(serde_json::json!({ "error": "Invalid email or password" })),
        ));
    }

    let auth_response = generate_token_pair(&state, user.id).await?;

    Ok((StatusCode::OK, Json(auth_response)))
}

/// POST /auth/refresh
pub async fn refresh(
    State(state): State<AppState>,
    Json(body): Json<RefreshRequest>,
) -> Result<impl IntoResponse, (StatusCode, Json<serde_json::Value>)> {
    let token_hash = hash_token(&body.refresh_token);

    let stored_token = state
        .auth_store
        .get_valid_refresh_token(&token_hash)
        .await
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(serde_json::json!({ "error": e.to_string() })),
            )
        })?
        .ok_or_else(|| {
            (
                StatusCode::UNAUTHORIZED,
                Json(serde_json::json!({ "error": "Invalid or expired refresh token" })),
            )
        })?;

    // Revoke the old token (rotation: each refresh token is single-use)
    state
        .auth_store
        .revoke_refresh_token(stored_token.id)
        .await
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(serde_json::json!({ "error": e.to_string() })),
            )
        })?;

    let auth_response = generate_token_pair(&state, stored_token.user_id).await?;

    Ok((StatusCode::OK, Json(auth_response)))
}

/// Generates an access token + refresh token pair and stores the refresh token in the DB.
async fn generate_token_pair(
    state: &AppState,
    user_id: Uuid,
) -> Result<AuthResponse, (StatusCode, Json<serde_json::Value>)> {
    let access_expires_in = 900; // 15 minutes

    let now = Utc::now();
    let claims = TokenClaims {
        sub: user_id.to_string(),
        iat: now.timestamp() as usize,
        exp: (now + Duration::seconds(access_expires_in)).timestamp() as usize,
    };

    let access_token = jwt::encode_token(&claims, &state.jwt_private_key).map_err(|e| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(serde_json::json!({ "error": e.to_string() })),
        )
    })?;

    // Generate raw refresh token (random UUID), hash it for storage
    let raw_refresh_token = Uuid::new_v4().to_string();
    let refresh_hash = hash_token(&raw_refresh_token);
    let refresh_expires_at = now + Duration::days(30);

    let refresh_record = RefreshToken {
        id: Uuid::new_v4(),
        user_id,
        token_hash: refresh_hash,
        expires_at: refresh_expires_at,
        revoked: false,
        created_at: now,
    };

    state.auth_store.store_refresh_token(&refresh_record).await.map_err(|e| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(serde_json::json!({ "error": e.to_string() })),
        )
    })?;

    Ok(AuthResponse {
        access_token,
        refresh_token: raw_refresh_token,
        token_type: "Bearer".to_string(),
        expires_in: access_expires_in,
    })
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use axum::{
    extract::{Request, State},
    http::StatusCode,
    middleware::Next,
    response::IntoResponse,
    Json,
};
use uuid::Uuid;

use crate::jwt;
use crate::AppState;

/// Authenticated user ID extracted from the JWT.
/// Handlers can use `Extension<AuthUser>` to access the authenticated user.
#[derive(Debug, Clone)]
pub struct AuthUser {
    pub user_id: Uuid,
}

/// Axum middleware that validates the `Authorization: Bearer <token>` header
/// and injects an `AuthUser` extension into the request.
pub async fn require_auth(
    State(state): State<AppState>,
    mut request: Request,
    next: Next,
) -> Result<impl IntoResponse, (StatusCode, Json<serde_json::Value>)> {
    let auth_header = request
        .headers()
        .get("Authorization")
        .and_then(|value| value.to_str().ok())
        .ok_or_else(|| {
            (
                StatusCode::UNAUTHORIZED,
                Json(serde_json::json!({ "error": "Missing Authorization header" })),
            )
        })?;

    let token = auth_header
        .strip_prefix("Bearer ")
        .ok_or_else(|| {
            (
                StatusCode::UNAUTHORIZED,
                Json(serde_json::json!({ "error": "Invalid Authorization format. Expected: Bearer <token>" })),
            )
        })?;

    let claims = jwt::decode_token(token, &state.jwt_public_key).map_err(|e| {
        (
            StatusCode::UNAUTHORIZED,
            Json(serde_json::json!({ "error": format!("Invalid token: {e}") })),
        )
    })?;

    let user_id = Uuid::parse_str(&claims.sub).map_err(|_| {
        (
            StatusCode::UNAUTHORIZED,
            Json(serde_json::json!({ "error": "Invalid user ID in token" })),
        )
    })?;

    // Inject the authenticated user into the request extensions
    request.extensions_mut().insert(AuthUser { user_id });

    Ok(next.run(request).await)
}

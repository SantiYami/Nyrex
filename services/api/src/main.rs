// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

mod auth_utils;
mod jwt;
mod middleware;
mod routes;

use axum::{middleware as axum_mw, routing::{get, post}, Router};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use store::{PgAuthStore, PgNyrexStore};
use tokio::net::TcpListener;

use base64::{engine::general_purpose, Engine as _};

#[derive(Clone)]
pub struct AppState {
    pub db: Arc<PgNyrexStore>,
    pub auth_store: Arc<PgAuthStore>,
    pub jwt_private_key: Vec<u8>,
    pub jwt_public_key: Vec<u8>,
}

#[tokio::main]
async fn main() {
    dotenvy::dotenv().ok();

    let database_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL environment variable must be set.");

    let priv_key_b64 = std::env::var("JWT_PRIVATE_KEY")
        .expect("JWT_PRIVATE_KEY environment variable must be set.");
    let pub_key_b64 = std::env::var("JWT_PUBLIC_KEY")
        .expect("JWT_PUBLIC_KEY environment variable must be set.");

    let jwt_private_key = general_purpose::STANDARD
        .decode(priv_key_b64)
        .expect("Invalid Base64 in JWT_PRIVATE_KEY");
    let jwt_public_key = general_purpose::STANDARD
        .decode(pub_key_b64)
        .expect("Invalid Base64 in JWT_PUBLIC_KEY");

    println!("Connecting to database...");

    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to construct Postgres Pool. Ensure Docker is running.");

    let state = AppState {
        db: Arc::new(PgNyrexStore::new(pool.clone())),
        auth_store: Arc::new(PgAuthStore::new(pool)),
        jwt_private_key,
        jwt_public_key,
    };

    // Public routes (no auth required)
    let public_routes = Router::new()
        .route("/health", get(health_check))
        .route("/auth/register", post(routes::auth::register))
        .route("/auth/login", post(routes::auth::login))
        .route("/auth/refresh", post(routes::auth::refresh));

    // Protected routes (auth required)
    let protected_routes = Router::new()
        .route("/me", get(me))
        .layer(axum_mw::from_fn_with_state(
            state.clone(),
            middleware::auth::require_auth,
        ));

    let app = Router::new()
        .merge(public_routes)
        .merge(protected_routes)
        .with_state(state);

    let listener = TcpListener::bind("0.0.0.0:3000").await.unwrap();
    println!("Server running on http://0.0.0.0:3000");

    axum::serve(listener, app).await.unwrap();
}

async fn health_check() -> &'static str {
    "Ok"
}

/// A simple protected endpoint to verify the middleware works.
async fn me(
    axum::Extension(auth_user): axum::Extension<middleware::auth::AuthUser>,
) -> axum::Json<serde_json::Value> {
    axum::Json(serde_json::json!({
        "user_id": auth_user.user_id.to_string(),
    }))
}

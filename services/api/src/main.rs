// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use axum::{routing::get, Router};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use store::PgNyrexStore;
use tokio::net::TcpListener;

#[derive(Clone)]
struct AppState {
    pub db: Arc<PgNyrexStore>,
}

#[tokio::main]
async fn main() {
    dotenvy::dotenv().ok();

    let database_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL environment variable must be set. Check your .env file.");

    println!("Connecting to database...");

    // Provide a lenient timeout to allow compiling safely even if DB is down initially
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to construct Postgres Pool. Ensure Docker is running.");

    let store = Arc::new(PgNyrexStore::new(pool));
    
    let state = AppState {
        db: store,
    };

    let app = Router::new()
        .route("/health", get(health_check))
        .with_state(state);

    let listener = TcpListener::bind("0.0.0.0:3000").await.unwrap();
    println!("Server running on http://0.0.0.0:3000");
    
    axum::serve(listener, app).await.unwrap();
}

async fn health_check() -> &'static str {
    "Ok"
}

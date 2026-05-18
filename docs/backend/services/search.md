# Nyrex — Backend: Search (Stage 6)

> Full-text search across unencrypted entities. Encrypted entries excluded.

## Phase 1 (v1.0)

**Local:** SQLite FTS5 for offline full-text search across notes, tasks.
**Backend:** PostgreSQL `tsvector` on `notes.title + notes.content`.

```sql
-- Already in schema
CREATE INDEX notes_fts_idx ON notes USING GIN(fts_vector);
```

```rust
// services/api/src/routes/search.rs
pub async fn search_notes(
    Extension(user_id): Extension<Uuid>,
    Query(params): Query<SearchParams>,
    State(pool): State<PgPool>,
) -> impl IntoResponse {
    let results = sqlx::query_as!(Note,
        "SELECT * FROM notes WHERE user_id = $1 AND fts_vector @@ plainto_tsquery($2)",
        user_id, params.q
    ).fetch_all(&pool).await?;
    Json(results)
}
```

## Phase 2 (Post-v1.0)

Migrate to **MeiliSearch** when search quality or performance demands it:
- Runs as separate Docker service
- Index after every write via background Tokio task
- Typo-tolerant, instant results

## Rules

- **Encrypted entries are NEVER indexed** — vault entries excluded
- Search results grouped by module in Command Palette
- Local FTS5 ensures search works fully offline

*Last updated: May 2026*

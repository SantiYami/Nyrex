# Nyrex — Backend: Sync Engine (Stage 6)

> Append-only event log. Push/pull. Last-write-wins with vault conflict escalation.

## Strategy

Each local write generates a `sync_event`. On reconnect, client pushes all pending events, then pulls remote changes.

```
local write → SQLite (sync_status = 'pending')
  ├── network available → POST /sync/push → backend applies
  │                        ← GET /sync/pull?since=... ← (pull remote)
  └── network unavailable → queue in SQLite, retry on reconnect
```

## Conflict Resolution

| Entity Type | Strategy |
|-------------|----------|
| Notes | Last-write-wins per field (timestamp comparison) |
| Tasks | Last-write-wins per field |
| Finance | Last-write-wins per field |
| Vault entries | **User-visible conflict modal**: Keep local / Use remote / Merge manually |

## Sync States

`sync_status` column on each local table:
- `synced` — matches backend
- `pending` — local changes not yet pushed
- `conflict` — divergent versions detected

## API Endpoints

- `POST /sync/push` — client sends batch of `sync_event` records
- `GET /sync/pull?since={timestamp}&client_id={id}` — server returns events since last sync
- Events include `client_id` to prevent echo (don't re-apply own events)

## Background Sync (Flutter)

- `connectivity_plus` package for network awareness
- Automatic push on reconnect
- Periodic pull every 30s when online
- `NxSyncIndicator` reflects current state

*Last updated: May 2026*

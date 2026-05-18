# Nyrex — Backend: Database Schema

> PostgreSQL (backend sync target) + SQLite/drift (local source of truth).

## PostgreSQL Schema

```sql
-- Users
CREATE TABLE users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email         TEXT UNIQUE NOT NULL,
  display_name  TEXT,
  sso_provider  TEXT,                    -- 'google' | 'microsoft' | null
  sso_sub       TEXT,                    -- OAuth subject claim
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Notes
CREATE TABLE notes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title         TEXT NOT NULL DEFAULT '',
  content       TEXT NOT NULL DEFAULT '',
  format        TEXT NOT NULL DEFAULT 'markdown',  -- 'markdown' | 'appflowy'
  folder_id     UUID REFERENCES note_folders(id),
  tags          TEXT[] DEFAULT '{}',
  is_encrypted  BOOLEAN DEFAULT FALSE,
  fts_vector    TSVECTOR GENERATED ALWAYS AS (
                  to_tsvector('english', title || ' ' || content)
                ) STORED,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ
);

-- Note folders
CREATE TABLE note_folders (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  parent_id     UUID REFERENCES note_folders(id),
  name          TEXT NOT NULL,
  sort_order    INT DEFAULT 0
);

-- Note links (backlinks)
CREATE TABLE note_links (
  source_note_id  UUID REFERENCES notes(id) ON DELETE CASCADE,
  target_note_id  UUID REFERENCES notes(id) ON DELETE CASCADE,
  PRIMARY KEY (source_note_id, target_note_id)
);

-- Vault entries (always encrypted — backend never sees plaintext)
CREATE TABLE vault_entries (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  ciphertext    BYTEA NOT NULL,
  nonce         BYTEA NOT NULL,
  hint          TEXT,
  category      TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ
);

-- Tasks
CREATE TABLE tasks (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  note_id       UUID REFERENCES notes(id),
  due_date      DATE,
  priority      SMALLINT DEFAULT 0,
  status        TEXT DEFAULT 'open',
  recurrence    JSONB,
  tags          TEXT[] DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ
);

-- Subtasks
CREATE TABLE subtasks (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id       UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  is_done       BOOLEAN DEFAULT FALSE,
  sort_order    INT DEFAULT 0
);

-- Finance: categories, budgets, items, debts, savings
CREATE TABLE finance_categories (
  id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name    TEXT NOT NULL,
  icon    TEXT,
  color   TEXT,
  type    TEXT DEFAULT 'variable'
);

CREATE TABLE budgets (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  month       INT NOT NULL,
  income      NUMERIC NOT NULL,
  template_id UUID,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE budget_items (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  budget_id   UUID NOT NULL REFERENCES budgets(id) ON DELETE CASCADE,
  category_id UUID REFERENCES finance_categories(id),
  planned     NUMERIC NOT NULL,
  spent       NUMERIC DEFAULT 0,
  is_active   BOOLEAN DEFAULT TRUE,
  sort_order  INT DEFAULT 0
);

CREATE TABLE debts (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind            TEXT NOT NULL,    -- credit_card|bank_loan|personal_loan
  name            TEXT NOT NULL,
  total_amount    NUMERIC NOT NULL,
  remaining       NUMERIC NOT NULL,
  interest_rate   NUMERIC,
  credit_limit    NUMERIC,
  monthly_payment NUMERIC,
  due_day         INT,
  vault_entry_id  UUID,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE savings_accounts (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id               UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name                  TEXT NOT NULL,
  target_amount         NUMERIC NOT NULL,
  current_amount        NUMERIC DEFAULT 0,
  monthly_contribution  NUMERIC DEFAULT 0,
  created_at            TIMESTAMPTZ DEFAULT NOW()
);

-- Sync events (append-only log)
CREATE TABLE sync_events (
  id            BIGSERIAL PRIMARY KEY,
  user_id       UUID NOT NULL REFERENCES users(id),
  entity_type   TEXT NOT NULL,
  entity_id     UUID NOT NULL,
  operation     TEXT NOT NULL,    -- create|update|delete
  payload       JSONB,
  client_id     TEXT NOT NULL,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX notes_fts_idx ON notes USING GIN(fts_vector);
CREATE INDEX notes_user_id_idx ON notes(user_id);
CREATE INDEX notes_updated_at_idx ON notes(updated_at);
CREATE INDEX tasks_user_due_idx ON tasks(user_id, due_date);
CREATE INDEX sync_events_user_idx ON sync_events(user_id, created_at);
```

## SQLite Local Schema (drift)

Mirrors PostgreSQL with two additions per table:
- `sync_status TEXT DEFAULT 'pending'` — `synced` | `pending` | `conflict`
- `local_only INTEGER DEFAULT 0` — drafts that should not sync yet

*Last updated: May 2026*

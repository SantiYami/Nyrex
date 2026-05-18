# Nyrex v1.0 — Module: Tasks (Stage 4)

> Personal task capture with dates, priorities, recurrence, NLP parsing, and cross-module links.

---

## Module Path

```
modules/tasks/
├── data/
│   ├── datasources/
│   │   └── tasks_local_datasource.dart
│   ├── models/
│   │   ├── task_model.dart
│   │   ├── subtask_model.dart
│   │   └── recurrence_rule_model.dart
│   └── repositories/
│       └── tasks_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── task.dart              # Freezed: id, title, due_date, priority, status, recurrence, note_id
│   │   ├── subtask.dart
│   │   └── recurrence_rule.dart   # daily|weekly|monthly|custom
│   └── repositories/
│       └── tasks_repository.dart
└── presentation/
    ├── providers/
    │   ├── tasks_provider.dart
    │   └── task_views_provider.dart    # Today/List/Board state
    ├── screens/
    │   ├── tasks_today_screen.dart
    │   ├── tasks_list_screen.dart
    │   ├── tasks_board_screen.dart
    │   └── task_detail_screen.dart
    └── widgets/
        ├── task_tile.dart
        ├── task_quick_capture.dart     # NLP input bar
        ├── task_detail_panel.dart
        ├── task_view_switcher.dart
        ├── task_priority_badge.dart
        └── task_subtask_list.dart
```

---

## Data Model (Local SQLite)

```sql
tasks (
  id          TEXT PRIMARY KEY,
  title       TEXT NOT NULL,
  note_id     TEXT,              -- optional link to notes
  due_date    INTEGER,           -- epoch millis
  priority    INTEGER DEFAULT 0, -- 0=low, 1=medium, 2=high
  status      TEXT DEFAULT 'open', -- open|in_progress|done|archived
  recurrence  TEXT,              -- JSON recurrence rule
  tags        TEXT,              -- JSON array
  created_at  INTEGER,
  updated_at  INTEGER,
  sync_status TEXT DEFAULT 'pending'
)

subtasks (
  id       TEXT PRIMARY KEY,
  task_id  TEXT REFERENCES tasks(id),
  title    TEXT NOT NULL,
  is_done  INTEGER DEFAULT 0,
  sort_order INTEGER
)
```

---

## User Stories

### S4.1 — Quick Capture with NLP

> *As a user, I want a single-line input that parses natural language into task properties.*

- `NxTaskQuickCapture` organism: input with real-time NLP badge preview.
- Parsing rules:
  - `tomorrow`, `next monday`, `jan 15` → `due_date`
  - `!high`, `!medium`, `!low` → `priority`
  - `#tag` → `tags[]`
- Example: `"Buy groceries tomorrow !high #personal"` → due=tomorrow, priority=high, tag=personal.
- Press Enter to save. Tap badge to edit parsed value.
- Expands to full detail modal via button.

**Acceptance:** NLP extracts date, priority, tags. Saved to local DB instantly.

### S4.2 — Task Detail Panel

> *As a user, I want to view and edit task details: subtasks, priority, dates, recurrence, links.*

- Subtask list with completion toggle + add/delete.
- Priority selector: low (default), medium, high — colored badges.
- Due date picker.
- Recurrence rule editor: daily, weekly, monthly, custom (every N days/weeks).
- Cross-module link: attach to Note (select from note list).
- Completion animation: checkbox fills teal + task fades.
- Undo: 5-second snackbar after completion/deletion.

**Acceptance:** All fields persist. Recurring task generates next instance on completion.

### S4.3 — View Switcher

> *As a user, I want Today, List, and Board views.*

| View | Content | Layout |
|------|---------|--------|
| **Today** | Due today + overdue, sorted by priority | Vertical list, overdue section highlighted red |
| **List** | All tasks with smart filters (status, priority, tag, date range) | Sortable table/list |
| **Board** | Columns: Open → In Progress → Done | Drag-and-drop between columns |

- View preference persisted in `shared_preferences`.
- Sidebar shows view switcher tabs.

**Acceptance:** All three views render. Board drag-and-drop works.

### S4.4 — Tasks ↔ Notes Integration

> *As a user, I want to create a task from within a note using `@task "title"`.*

- In note editor, typing `@task "Buy milk"` creates a linked task.
- Task `note_id` references the source note.
- Task detail shows source note preview (title + first 2 lines).
- Deleting either side removes the link but not the other entity.

**Acceptance:** Bidirectional link works. Orphaned references handled gracefully.

---

*Last updated: May 2026*

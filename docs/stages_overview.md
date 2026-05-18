# Nyrex v1.0 — Stages Overview

> Cross-functional timeline, integration matrix, and resolved decisions.

## Resolved Decisions

| Question | Decision |
|----------|----------|
| Font family | **Inter** via `google_fonts` package |
| `appflowy_editor` | Added in **Stage 3** (Notes), not before |
| `modules/vault/` naming | **Rename to `modules/notes/`**. Fresh `modules/vault/` for passwords |
| Finance in v1.0 | **Yes** — all 4 core modules ship |

## Stage Map

| Stage | Name | Scope | Docs |
|-------|------|-------|------|
| **0** | Atomic Design System | Tokens, atoms, molecules, organisms, app shell, router | `frontend/structure/` |
| **1** | Global Flows | Command palette, focus mode, sync UI, empty states | `frontend/screens/` |
| **2** | Vault Module | Password manager — unlock, CRUD, categories, master pw change | `frontend/modules/vault.md` |
| **3** | Notes Module | Rich editor, folders, tags, backlinks, version history | `frontend/modules/notes.md` |
| **4** | Tasks Module | NLP capture, subtasks, recurrence, Today/List/Board views | `frontend/modules/tasks.md` |
| **5** | Finance Module | Dashboard, budget wizard, debt tracking, quick entry, savings | `frontend/modules/finance.md` |
| **6** | Sync & Polish | Sync engine, FTS, SSO, S3 backup, desktop builds, observability | `backend/services/` |

```
Stage 0 → Stage 1 → Stage 2 → Stage 3 → Stage 4 → Stage 5 → Stage 6
(foundation)  (UX)    (vault)   (notes)   (tasks)  (finance) (platform)
```

Stages 0–1 are sequential prerequisites. Stages 2–5 are core modules. Stage 6 is platform integration.

## Cross-Module Integration Matrix

| Integration | Stage | Mechanism |
|-------------|-------|-----------|
| Notes ↔ Tasks | S4.4 | `@task "title"` in editor creates linked task |
| Notes ↔ Finance | S5.6 | `/expense [amount]` opens Quick Entry pre-linked |
| Vault ↔ Finance | S5.6 | Sensitive debt data stored as Vault entry ref |
| Tasks ↔ Finance | S5.6 | Budget item → generates recurring task |
| `+ New` pre-fill | S0.4 | Contextual pre-fill + bidirectional link |

## Future Modules (Post-v1.0)

1. Bookmarks  2. Journal  3. Time Tracker  4. Code Snippets  5. Flashcards
6. Knowledge Graph  7. Reading List  8. Dashboard widgets  9. Health Tracker
10. AI Assistant  11. Integrations Hub  12. Self-Host Dashboard

*Last updated: May 2026*

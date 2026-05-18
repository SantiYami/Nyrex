# Nyrex v1.0 — Module: Notes (Stage 3)

> Rich block editor with Markdown storage, slash commands, folders, tags, and backlinks.

---

## Module Path

`apps/flutter/lib/modules/notes/` — **renamed from `vault/`** in Stage 0.

```
modules/notes/
├── data/
│   ├── datasources/
│   │   └── notes_local_datasource.dart
│   ├── models/
│   │   └── note_model.dart
│   └── repositories/
│       └── notes_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── note.dart             # Freezed: id, title, content, format, tags, folder_id
│   │   ├── note_folder.dart
│   │   └── note_link.dart        # Backlink reference
│   └── repositories/
│       └── notes_repository.dart
└── presentation/
    ├── providers/
    │   ├── notes_provider.dart
    │   ├── note_editor_provider.dart
    │   └── note_tree_provider.dart    # Folder/note hierarchy
    ├── screens/
    │   ├── note_list_screen.dart
    │   └── note_editor_screen.dart
    └── widgets/
        ├── note_tile.dart
        ├── note_tree_view.dart        # Sidebar folder tree
        ├── note_format_toolbar.dart    # Floating on selection
        ├── note_slash_menu.dart        # / command menu
        ├── note_tag_chips.dart
        └── note_backlinks_panel.dart
```

---

## Storage Strategy

- **Default format:** Markdown. Stored as plain text in SQLite `content` column.
- **Rich format:** AppFlowy JSON when document uses rich blocks (toggles, callouts, embeds).
- **Field:** `format = 'markdown' | 'appflowy'` — auto-detected based on content.
- **Export:** Markdown always available regardless of storage format.

---

## Dependency

`appflowy_editor` added to `pubspec.yaml` in this stage (not earlier).

---

## User Stories

### S3.1 — Note Editor Canvas

> *As a user, I want a rich editor with floating format toolbar and slash commands.*

- `appflowy_editor` with custom Nyrex theme styling (dark tokens).
- **Format toolbar:** appears on text selection. Options: bold, italic, code, link, heading level.
- **Slash menu** (`/`): heading, bullet list, numbered list, toggle, callout, code block, divider, quote.
- Auto-save to local SQLite (debounced 500ms after last keystroke).
- Markdown round-trip: import from MD, export to MD.

**Acceptance:** Rich editing works. MD round-trips correctly. Auto-save persists.

### S3.2 — Sidebar Folder Tree

> *As a user, I want a hierarchical folder/note tree in the sidebar.*

- Folders can be nested (max 3 levels for UX sanity).
- Notes live inside folders or at root level.
- Drag-and-drop to move notes between folders.
- Context menu: rename, delete, move to folder, duplicate.
- Sidebar uses `NxNavGroup` molecule for each folder level.

**Acceptance:** Tree state persists across sessions. Drag-and-drop works.

### S3.3 — Tags & Backlinks

> *As a user, I want to tag notes and see which notes link to the current one.*

- **Tags:** chips in editor header area. Add/remove inline. Filter by tag in sidebar.
- **Internal links:** `[[Note Title]]` syntax. Auto-complete on `[[` trigger.
- **Backlinks panel:** below editor content, lists all notes that link to the current note.
- Stored in `note_links` junction table: `source_note_id ↔ target_note_id`.

**Acceptance:** Tags filterable in sidebar. Backlinks update when links added/removed.

### S3.4 — Focus Mode (Editor)

> *As a user, I want focus mode to show only the writing surface.*

- Reuses Stage 1 focus mode (S1.2).
- Editor-specific: also hides format toolbar until text selection.
- Sidebar collapses, rail dims.

**Acceptance:** Focus mode works seamlessly in editor context.

### S3.5 — Version History

> *As a user, I want to view and restore previous versions of a note.*

- Snapshots stored on significant edits (debounced — max 1 snapshot per 5 minutes).
- Version list: timestamp + content diff preview.
- Restore: creates new snapshot of current, then replaces content with selected version.
- Max 50 versions per note (FIFO cleanup).

**Acceptance:** Can restore any previous version. Current version preserved as new snapshot.

---

## Cross-Module Integration (Implemented in Other Stages)

| Integration | Stage | How |
|-------------|-------|-----|
| Notes → Tasks | S4.4 | `@task "title"` creates linked task |
| Notes → Finance | S5.6 | `/expense [amount]` opens Quick Entry |

*Last updated: May 2026*

# Nyrex — Screen: Command Palette (Stage 1)

> Global navigation + quick actions. Keyboard-first. `⌘K` / `Ctrl+K`.

## Layout

- **Desktop:** Centered modal `480px` wide, bg `#1A1A24`, r16, border `#2E2E3E`.
- **Mobile:** `90vh` bottom sheet.
- Rail/sidebar dimmed 20% while open.

## Content

### Input
`Search or execute command...` placeholder + `ESC` NxKbd pill right-aligned.
Auto-focuses on open.

### Result Groups

| Group | Items |
|-------|-------|
| `MODULES` | Notes · Vault · Tasks · Finance (with module icons) |
| `QUICK ACTIONS` | New Note `⌘N` · Log Expense `⌘E` · Lock `⌘L` · Focus `⌘+Shift+F` |
| `RECENT CONTEXT` | 3 recent items with module icon + timestamp |

### Interaction

| Action | Behavior |
|--------|----------|
| Arrow keys | Navigate between results |
| Enter | Select highlighted item |
| Mouse click | Select item |
| `ESC` / backdrop click | Close palette |
| Typing | Filters results. Match text highlights teal (`#00D4AA`) |

**Selected row:** bg `#3D3499`, text `#AFA9EC`.

## Keyboard Shortcuts

Implemented via `Shortcuts` + `Actions` + `CallbackShortcuts` at `NxAppShell` level.

| Shortcut | Action |
|----------|--------|
| `⌘K` / `Ctrl+K` | Open palette |
| `⌘N` / `Ctrl+N` | New Note |
| `⌘E` / `Ctrl+E` | Log Expense |
| `⌘L` / `Ctrl+L` | Lock workspace |
| `⌘+Shift+F` / `Ctrl+Shift+F` | Toggle focus mode |
| `ESC` | Close palette / exit focus mode |

Platform detection via `Platform.isMacOS` for ⌘ vs Ctrl labels.

*Last updated: May 2026*

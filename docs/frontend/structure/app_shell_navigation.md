# Nyrex — App Shell & Navigation (Stage 0)

> Three-layer immutable shell. Navigation never changes per module — only content adapts.

## Shell Architecture

```
┌────────────────────────────────────────────────────────────┐
│  [Icon Rail 52px]  [Sidebar 200-280px]  [Main Content 1fr] │
│  #0F0F14           #1A1A24               #0F0F14     │
└────────────────────────────────────────────────────────────┘
```

## Layer 1: Icon Rail (`NxIconRail`)

- Width: `52px` | Bg: `#0F0F14` | Right border: `#252535`
- Fixed order, max 7 items, never hides (dims to 20% in focus mode).

| Position | Item       | Icon                              |
| -------- | ---------- | --------------------------------- |
| 1        | Home       | `home_outlined`                   |
| 2        | Notes      | `edit_note_outlined`              |
| 3        | Vault      | `lock_outlined`                   |
| 4        | Tasks      | `check_circle_outline`            |
| 5        | Finance    | `account_balance_wallet_outlined` |
| —        | _(spacer)_ | —                                 |
| 7        | Settings   | `settings_outlined`               |

**States:**

- Default: icon `#555568`
- Hover: bg `#22222F`, icon `#E8E8F0`
- Active: bg `#3D3499`, icon `#7C6AF7`, 3×20px violet bar on left edge

## Layer 2: Sidebar (`NxSidebar`)

- Width: `200px` (collapse to `48px`, expand to `280px`) | Bg: `#1A1A24`
- Structure (always): `[SearchBar ⌘K]` → `[+ New X]` → `[NavGroup list/tree]`
- Nav items: padding 7×10, r8, active bg `#3D3499`, text `#AFA9EC`, left dot `#7C6AF7`
- Mobile: slide-out drawer via hamburger or swipe.

## Layer 3: Main Content

- Bg: `#0F0F14` | Min padding: `24px`
- No navigation chrome inside.
- Overlays (Command Palette, Quick Entry, Modals) sit on top, dim background 20%.

## Responsive Breakpoints

| Breakpoint            | Rail                | Sidebar          | Content    |
| --------------------- | ------------------- | ---------------- | ---------- |
| `< 600px` (mobile)    | Hidden → bottom nav | Slide-out drawer | Full width |
| `600–1024px` (tablet) | Compact 48px        | Collapsible      | Remaining  |
| `> 1024px` (desktop)  | Fixed 52px          | 200px default    | 1fr        |

**Flutter:** `LayoutBuilder` + `MediaQuery` for breakpoints. `AnimatedContainer` for sidebar collapse.

## Router Integration (Stage 0.5)

```dart
GoRouter(
  initialLocation: '/login',
  routes: [
    // Auth — OUTSIDE shell
    GoRoute(path: '/login', ...),
    GoRoute(path: '/register', ...),

    // Shell — wraps all module content
    ShellRoute(
      builder: (ctx, state, child) => NxAppShell(child: child),
      routes: [
        GoRoute(path: '/home', ...),
        GoRoute(path: '/notes', ...),
        GoRoute(path: '/vault', ...),
        GoRoute(path: '/tasks', ...),
        GoRoute(path: '/finance', ...),
        GoRoute(path: '/settings', ...),
      ],
    ),
  ],
)
```

## Focus Mode (Stage 1.2)

- Trigger: `Ctrl+Shift+F` or header button.
- Rail dims 20%, sidebar collapses to 48px, toolbars hide.
- Content expands. Exit: `ESC` or button.
- State in Riverpod provider (not persisted across sessions).

_Last updated: May 2026_

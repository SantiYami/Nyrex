# Nyrex — Atomic Design System (Stage 0)

> Component inventory and directory layout. Atoms → Molecules → Organisms.
> Visual spec verified against design images (source of truth).

## Directory Layout

```
lib/
├── core/
│   └── theme/
│       ├── tokens/               # See design_tokens.md
│       │   ├── colors.dart
│       │   ├── typography.dart   # Inter + JetBrains Mono
│       │   ├── spacing.dart
│       │   └── radii.dart
│       ├── app_theme.dart        # ThemeData builder (uses tokens/)
│       └── theme_provider.dart   # Riverpod provider
│
├── design_system/
│   ├── atoms/
│   ├── molecules/
│   └── organisms/
│
└── modules/
    ├── auth/
    ├── notes/                    # Renamed from vault/
    ├── vault/                    # New — password manager
    ├── tasks/
    └── finance/
```

---

## 04 · Atoms (`design_system/atoms/`)

### NxButton (`nx_button.dart`)

Height: `32px` (compact/sm) or `36px` (standard/md).

| Variant | Fill | Text | Border | Hover |
|---------|------|------|--------|-------|
| `primary` | `#7C6AF7` | white | none | bg → `#5A4FD6` |
| `secondary` | `bg-2` | `text-1` | `border` 1px | bg lightens |
| `ghost` | transparent | `text-2` | none | bg → `bg-2` |
| `danger` | `#FF5C5C` | white | none | darken 10% |
| `disabled` | transparent | 40% opacity | `border` 1px | none (no pointer) |

- Optional leading icon via `icon` prop.
- `const` constructor. Animations ≤200ms `Curves.easeOut`.
- Hover gated by platform: `kIsWeb || desktop`.

### NxInput (`nx_input.dart`)

Height: `36px`. Padding: `0 12px`. Fill: `bg-0`. Radius: `kRadius8`.

| State | Border | Extra |
|-------|--------|-------|
| `default` | `border` 1px | Placeholder: `text-3` |
| `focus` | `primary` 1px | `0 0 0 2px primary/20` glow ring |
| `error` | `error` 1px | Helper text in `error` color |
| `success` | `success` 1px | Helper text in `success` color |

- Optional `leadingIcon`.
- Filled state: text `text-1`, bg stays `bg-0`.

### NxBadge (`nx_badge.dart`)

Pill shape. Caption size (11px/600). Bg: `bg-2`. Radius: `full` (9999px).

| Variant | Border | Text |
|---------|--------|------|
| `default` | none | `text-2` |
| `selected` | `primary` | `primary` |
| `saved` | `confirmation` | `confirmation` |
| `within` | `success` | `success` |
| `warning` | `warning` | `warning` |
| `over` | `error` | `error` |
| `info` | `info` | `info` |

### NxToggle (`nx_toggle.dart`)

36×20px. Thumb: white. Track off: `border`. Track on: `primary`. Transition: 200ms.

### NxIconButton (`nx_icon_button.dart`)

Ghost icon tap target. Radius: `kRadius8`. Hover: bg `bg-2`. Icon color: `text-2`, hover: `text-1`.

### NxMoneyDisplay (`nx_money_display.dart`)

JetBrains Mono. `FontFeature.tabularFigures()`. Color by state: `text-1` (normal), `success` (positive), `warning` (caution), `error` (deficit).

### NxKbd (`nx_kbd.dart`)

Small pill: bg `bg-2`, border `border`, mono caption text (11px).
Platform-adaptive: `⌘` on macOS, `Ctrl` on Windows/Linux.
Examples shown in images: `⌘K`, `N`, `T`, `↵`, `ESC`.

### NxProgressBar (`nx_progress_bar.dart`)

Track: `bg-1`. Height: 4–6px. Radius: `full`.
Fill color by semantic state:
- Green (`success`): healthy / within budget
- Yellow (`warning`): approaching threshold
- Red (`error`): exceeded / critical

---

## Molecules (`design_system/molecules/`)

| Component | File | Composition | Key Behavior |
|-----------|------|-------------|-------------|
| `NxSearchBar` | `nx_search_bar.dart` | NxInput + NxKbd(⌘K) | Focus opens command palette |
| `NxNavGroup` | `nx_nav_group.dart` | H3 header + list of nav items | Collapsible. Active: bg `primary-muted`, text `#AFA9EC`, left dot `primary` |
| `NxItemCard` | `nx_item_card.dart` | Icon + labels + NxProgressBar + NxToggle + action | bg-2, border, r12. Hover → primary border |
| `NxEmptyState` | `nx_empty_state.dart` | Icon(`text-3`) + body text(`text-2`) + NxButton CTA | Centered composition |
| `NxSyncIndicator` | `nx_sync_indicator.dart` | NxBadge variant | synced=teal, pending=yellow pulse, offline=red |
| `NxWizardStepper` | `nx_wizard_stepper.dart` | Step dots + labels | Active: violet underline. Completed: teal check |

---

## Organisms (`design_system/organisms/`)

| Component | File | Description |
|-----------|------|-------------|
| `NxAppShell` | `nx_app_shell.dart` | Three-layer shell: rail + sidebar + content. See `app_shell_navigation.md` |
| `NxIconRail` | `nx_icon_rail.dart` | 52px fixed global nav. See `app_shell_navigation.md` |
| `NxSidebar` | `nx_sidebar.dart` | 200–280px collapsible module nav |
| `NxCommandPalette` | `nx_command_palette.dart` | ⌘K modal. See `screens/command_palette.md` |

---

## Component Rules Summary

- **No shadows on flat elements.** Only floating/modals get `0 4px 12px rgba(0,0,0,0.2)`.
- **Row height in lists:** 32–40px (compact density).
- **Separators:** `divider` color, 1px.
- **Right-aligned actions:** use `mono` for shortcuts.
- **Cards:** bg-1 or bg-2, border, r16 for structural, r12 for data.
- **All animations ≤200ms.** `Curves.easeOut` or `Curves.easeInOut`.

*Last updated: May 2026*

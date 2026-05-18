# Nyrex — Stage 0 Progress Tracker

> Design system foundation. Must be 100% before any module work begins.

---

## S0.1 · Design Tokens ✅

| Item | Status | File |
|------|--------|------|
| Add `google_fonts` dependency | ✅ Done | `pubspec.yaml` |
| Color tokens (brand, surfaces ×3, text, semantic) | ✅ Done | `tokens/colors.dart` |
| Typography tokens (Inter + JetBrains Mono, scale) | ✅ Done | `tokens/typography.dart` |
| Spacing tokens (4px grid, xs → 4xl) | ✅ Done | `tokens/spacing.dart` |
| Radius tokens (sm → full, BorderRadius constants) | ✅ Done | `tokens/radii.dart` |
| Barrel export | ✅ Done | `tokens/tokens.dart` |
| Rewrite `app_theme.dart` to use tokens | ✅ Done | `app_theme.dart` |
| Remove deprecated shims + migrate consumers | ✅ Done | 5 screens updated |
| `flutter analyze` passes | ✅ Done | 0 issues |

---

## S0.2 · Atom Components ✅

| Item | Status | File |
|------|--------|------|
| `NxButton` (primary/secondary/ghost/danger/disabled, sm/md) | ✅ Done | `design_system/atoms/nx_button.dart` |
| `NxInput` (default/focus/error/success, leadingIcon) | ✅ Done | `design_system/atoms/nx_input.dart` |
| `NxBadge` (7 variants: default→info) | ✅ Done | `design_system/atoms/nx_badge.dart` |
| `NxToggle` (on/off, 36×20px) | ✅ Done | `design_system/atoms/nx_toggle.dart` |
| `NxIconButton` (ghost, hover) | ✅ Done | `design_system/atoms/nx_icon_button.dart` |
| `NxMoneyDisplay` (JetBrains Mono, semantic color) | ✅ Done | `design_system/atoms/nx_money_display.dart` |
| `NxKbd` (platform-adaptive shortcut pill) | ✅ Done | `design_system/atoms/nx_kbd.dart` |
| `NxProgressBar` (semantic fill: green/yellow/red) | ✅ Done | `design_system/atoms/nx_progress_bar.dart` |
| Barrel export (`atoms.dart`) | ✅ Done | `design_system/atoms/atoms.dart` |
| `flutter analyze` passes | ✅ Done | 0 issues |

---

## S0.3 · Molecule Components ✅

| Item | Status | File |
|------|--------|------|
| `NxSearchBar` (NxInput + NxKbd) | ✅ Done | `design_system/molecules/nx_search_bar.dart` |
| `NxNavGroup` (collapsible header + nav items) | ✅ Done | `design_system/molecules/nx_nav_group.dart` |
| `NxItemCard` (icon + labels + progress + toggle) | ✅ Done | `design_system/molecules/nx_item_card.dart` |
| `NxEmptyState` (icon + text + CTA) | ✅ Done | `design_system/molecules/nx_empty_state.dart` |
| `NxSyncIndicator` (synced/pending/offline pill) | ✅ Done | `design_system/molecules/nx_sync_indicator.dart` |
| `NxWizardStepper` (active/completed step dots) | ✅ Done | `design_system/molecules/nx_wizard_stepper.dart` |
| Barrel export (`molecules.dart`) | ✅ Done | `design_system/molecules/molecules.dart` |
| `flutter analyze` passes | ✅ Done | 0 issues |

---

## S0.4 · Organisms (App Shell) ✅

| Item | Status | File |
|------|--------|------|
| `NxIconRail` (52px, 7 items, active state) | ✅ Done | `design_system/organisms/nx_icon_rail.dart` |
| `NxSidebar` (200-280px, collapsible, mobile drawer) | ✅ Done | `design_system/organisms/nx_sidebar.dart` |
| `NxAppShell` (rail + sidebar + content, breakpoints) | ✅ Done | `design_system/organisms/nx_app_shell.dart` |
| `NxCommandPalette` (⌘K modal, grouped results) | ✅ Done | `design_system/organisms/nx_command_palette.dart` |
| Barrel export (`organisms.dart`) | ✅ Done | `design_system/organisms/organisms.dart` |
| `flutter analyze` passes | ✅ Done | 0 issues |

---

## S0.5 · Router Integration ✅

| Item | Status | File |
|------|--------|------|
| Wrap all routes in `ShellRoute` → `NxAppShell` | ✅ Done | `core/router/app_router.dart` |
| Auth routes outside shell | ✅ Done | `core/router/app_router.dart` |
| Keyboard shortcuts at shell level | ✅ Done | `nx_app_shell.dart` |
| `flutter analyze` passes | ✅ Done | 0 issues |

---

## S0.6 · Migration & Rename 🔲

| Item | Status | File |
|------|--------|------|
| Rename `modules/vault/` → `modules/notes/` | 🔲 | directory rename |
| Create new `modules/vault/` scaffold (password mgr) | 🔲 | new directory |
| Migrate existing screens to use design system atoms | 🔲 | login, register, etc. |
| `flutter analyze` passes | 🔲 | — |

---

*Legend: ✅ Done · 🔧 In Progress · 🔲 Not Started*

*Last updated: 2026-05-07*

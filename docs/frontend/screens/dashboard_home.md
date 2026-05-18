# Nyrex — Screen: Dashboard / Home (Stage 1)

> Unified operational overview. Control plane, not a feed. Dense, scannable, instant feedback.

## Layout

3-column grid in main area (desktop). Stacked cards (mobile). Sidebar shows home module context.

## Sidebar (Home Module)

| Section | Content |
|---------|---------|
| Search | `NxSearchBar` with ⌘K |
| Action | `+ New Note` (secondary button) |
| `RECENT CONTEXT` | 3 recent items with timestamps |
| `SYSTEM` | Sync pill (`NxSyncIndicator`), storage meter bar |

## Main Area Cards

### Card 1: PENDING OPERATIONS

Mixed list of tasks and finance due items:
- `[ ] Review PR #842` — Task, High priority
- `⏳ Pay Cloud Hosting` — Finance, Due Today
- `[ ] Draft Contract` — Task, Medium priority

**Interactions:**
- Checkbox toggle → teal fill + strikethrough (200ms). Instant list update.
- Click item → opens detail panel (slide-in from right or modal).

### Card 2: RESOURCE ALLOCATION

| Element | Display |
|---------|---------|
| Hero amount | `$1,250.00` — `NxMoneyDisplay`, semantic color by budget health |
| Progress bar | `Monthly Budget · 62% utilized` — green/yellow/red by % |
| Next due | `Next: Rent · May 15` — secondary text |
| Action | `Log Transaction` — primary `NxButton` |

**Interactions:**
- `Log Transaction` → opens Quick-Log modal. Background dims 20%.
- Card hover → border `#7C6AF7`.

### Card 3: SYSTEM STATUS

| Item | Display |
|------|---------|
| Vault | `3/3 Secure` — teal text |
| Sync | `Active` — teal, or `Pending` yellow, or `Offline` red |
| Last Backup | `2h ago` — mono timestamp |
| Storage | `1.2GB/5GB` — progress bar |

**Actions:**
- `Lock Workspace` (ghost button)
- `Run Backup` (secondary button)

## Micro-interactions

- `Log Transaction` → Quick-Log modal overlay. Rail/sidebar dim 20%.
- Checkbox toggle → teal fill + strikethrough, 200ms.
- Sync pill pulses every 10s if actively syncing.
- Hero amount updates with teal flash on new transaction.

## Flutter Mapping

| Element | Widget | Notes |
|---------|--------|-------|
| Grid | `GridView.count(crossAxisCount: 3)` | Mobile: `Column` in `SingleChildScrollView` |
| Cards | `Container(BoxDecoration)` | bg-2 `#22222F`, border `#2E2E3E`, r12 |
| Hero amount | `NxMoneyDisplay` | Mono, tabular-nums, semantic color |
| Quick-Log | `showModalBottomSheet` / `showDialog` | `isScrollControlled: true`, bg-1, r16 |
| Sliver perf | Use `SliverGrid` if lists grow | Maintain native scroll performance |

*Last updated: May 2026*

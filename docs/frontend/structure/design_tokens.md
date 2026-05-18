# Nyrex — Design Tokens (Stage 0)

> Single source of truth for all visual constants. Located at `core/theme/tokens/`.
> **Images are canonical.** If YAML conflicts with visual spec, images win.

---

## Color System (`tokens/colors.dart`)

Tokens are divided into structural layers, interactive states, and semantic feedback.
Always use token constants — never hardcode hex values in widgets.

### 01 · Surface Scale (Dark, Canonical)

Three layers. Canvas → sidebars/modals → cards. Borders + dividers separate without shadow.

| Token | Hex | CSS var | Role |
|-------|-----|---------|------|
| `bg-0` · canvas | `#0F0F14` | `--bg-0` | App background, root layer |
| `bg-1` · sidebar | `#1A1A24` | `--bg-1` | Sidebars, main content panels, modals |
| `bg-2` · cards | `#22222F` | `--bg-2` | Cards, elevated elements, popovers |
| `border` | `#2E2E3E` | `--border` | Input borders, card strokes |
| `divider` | `#252535` | `--divider` | List separators, subtle boundaries |
| `text-1` | `#E8E8F0` | `--text-1` | Primary text (high emphasis) |
| `text-2` | `#9090A8` | `--text-2` | Secondary text (medium emphasis) |
| `text-3` | `#555568` | `--text-3` | Disabled text (low emphasis) |

### AMOLED Surfaces (Override)

| Token | Hex |
|-------|-----|
| `bg-0` | `#000000` |
| `bg-1` | `#0A0A0A` |
| `bg-2` | `#111111` |
| `border` | `#1C1C1C` |

### Light Surfaces (Override)

| Token | Hex |
|-------|-----|
| `bg-0` | `#F4F4FA` |
| `bg-1` | `#FFFFFF` |
| `bg-2` | `#F0F0FA` |
| `border` | `#E0E0F0` |
| `divider` | `#EEEEFF` |
| `text-1` | `#1A1A2E` |
| `text-2` | `#555570` |
| `text-3` | `#AAAAAC` |

### 02 · Color Roles (Fixed Semantics)

**Rule:** Violet = power & selection. Teal = confirmation. Semantic = status only, never decorative.

| Token | Hex | CSS var | Usage |
|-------|-----|---------|-------|
| `primary` · violet | `#7C6AF7` | `--acc` | CTAs, active states, selection, focus rings |
| `primary-hover` | `#5A4FD6` | `--primary-hover` | Pointer hover on primary elements |
| `primary-muted` | `#3D3499` | `--primary-muted` | Active nav backgrounds, subtle tinted fills |
| `confirmation` · teal | `#00D4AA` | `--confirm` | Completed actions, positive confirmation |
| `success` · within | `#3DDC84` | `--success` | Within limits, healthy state |
| `warning` · 80%+ | `#FFC947` | `--warning` | Early warning, 80% threshold |
| `error` · exceeded | `#FF5C5C` | `--error` | Validation errors, exceeded, overdue |
| `info` | `#4DA6FF` | `--info` | Informational states |

### Material 3 Extended Mapping

For `ColorScheme` compatibility. Derived from design YAML:

| M3 Token | Hex | Maps to |
|----------|-----|---------|
| `surface` | `#13121B` | ≈ bg-0 |
| `surfaceContainerLow` | `#1C1A24` | ≈ bg-1 |
| `surfaceContainer` | `#201E28` | ≈ bg-2 |
| `surfaceContainerHigh` | `#2A2933` | elevated cards |
| `surfaceContainerHighest` | `#35343E` | top-level floating |
| `onSurface` | `#E5E0EE` | ≈ text-1 |
| `onSurfaceVariant` | `#C9C4D7` | ≈ text-2 |
| `outline` | `#928EA0` | interactive borders |
| `outlineVariant` | `#474554` | ≈ border |
| `primary` | `#C7BFFF` | light primary for M3 |
| `primaryContainer` | `#8E7FFF` | ≈ primary accent |
| `secondary` | `#41EEC2` | ≈ confirmation teal |
| `tertiary` | `#FFB86D` | warm accent (finance) |
| `error` | `#FFB4AB` | error on dark |
| `inversePrimary` | `#5A46D3` | ≈ primary-hover |

---

## Typography (`tokens/typography.dart`)

**UI font:** `Inter` (loaded via `google_fonts` package).
**Mono font:** `JetBrains Mono` with tabular nums for all numbers, timestamps, tokens.

### 03 · Type Scale

| Token | Size | Weight | Line Height | Letter Spacing | Notes |
|-------|------|--------|-------------|---------------|-------|
| `display` | 28px | 700 | 1.2 | -0.02em | Page titles |
| `h1` | 22px | 600 | 1.3 | -0.01em | Section heads |
| `h2` | 17px | 600 | 1.4 | -0.01em | Subsections |
| `h3` | 14px | 600 | 1.4 | — | Labels, group titles |
| `body` | 14px | 400 | 1.5 | — | Default content |
| `secondary` | 13px | 400 | 1.5 | — | Metadata, timestamps |
| `caption` | 11px | 400 | 1.4 | — | Fine print, badges |
| `mono` | 12px | 400 | 1.2 | — | JetBrains Mono, `tabularFigures()` |

**Emphasis scale:** High (`text-1`) → Medium (`text-2`) → Low/Disabled (`text-3`).

**Rules:**
- Weight drives hierarchy more than size. `600` for headings, `400` for body.
- All financial amounts, counts, percentages, timestamps, IDs, and keyboard shortcuts use `mono`.
- `FontFeature.tabularFigures()` applied globally to mono style.

---

## Spacing (`tokens/spacing.dart`)

**4px grid.** All spacing, padding, and margins are multiples of 4px.

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Tight internal gaps |
| `sm` | 8px | Internal component padding |
| `md` | 12px | Medium internal padding |
| `lg` | 16px | Section gaps, gutter |
| `xl` | 20px | Large separation |
| `2xl` | 24px | Viewport margin, major sections |
| `3xl` | 32px | Page-level spacing |
| `4xl` | 48px | Hero spacing |

Layout: 12-column fluid grid. `gutter: 16px`, `margin: 24px` (viewport edges).

---

## Radii (`tokens/radii.dart`)

| Token | Value | Usage |
|-------|-------|-------|
| `sm` / `kRadius4` | 4px (0.25rem) | Badges, kbd hints, chips |
| `DEFAULT` / `kRadius8` | 8px (0.5rem) | Buttons, inputs, dropdowns |
| `md` / `kRadius12` | 12px (0.75rem) | Compact cards, table rows |
| `lg` / `kRadius16` | 16px (1rem) | Structural panels, modals |
| `xl` / `kRadius24` | 24px (1.5rem) | Full-screen overlays, command palette |
| `full` | 9999px | Circular badges, pills |

---

## Elevation & Depth

Depth relies on **tonal layering + low-contrast outlines**, not heavy shadows.

| Level | Surface | Usage |
|-------|---------|-------|
| 0 | `bg-0` | Canvas (root) |
| 1 | `bg-1` | Panels, sidebars |
| 2 | `bg-2` | Cards, floating UI |

**Shadows:** Only for floating/modals: `1px border + 0 4px 12px rgba(0,0,0,0.2)`. No blur on flat elements.

---

## Component Rules (from design spec)

### Buttons
- Height: `32px` (compact) or `36px` (standard).
- Primary: `primary` fill, white text. Hover → `primary-hover`.
- Secondary: `bg-2` fill, `border` stroke. Hover → lighter bg.
- Ghost: transparent bg, text only. Hover → `bg-2` fill.
- Delete/Danger: `error` fill, white text.
- Disabled: `border` stroke, 40% opacity text.
- Kbd pills: `bg-2`, `border`, mono 11px.

### Inputs
- Fill: `bg-0`. Border: `border` (1px). Height: `36px`. Padding: `0 12px`.
- Focus: border → `primary` + `0 0 0 2px primary/20` glow.
- Error: border → `error`.
- Success: border → `success`.

### Pills / Badges
- DEFAULT: `bg-2` fill, `text-2` text, no border.
- SELECTED: `primary` border, `primary` text.
- SAVED: `confirmation` border, `confirmation` text.
- WITHIN: `success` border, `success` text.
- 80%: `warning` border, `warning` text.
- OVER: `error` border, `error` text.
- INFO: `info` border, `info` text.

### Progress Bars
- Track: `bg-1`.
- Fill color by semantic state: green (healthy), yellow (warning), red (exceeded/error).
- Height: 4–6px. Radius: full.

### Kbd Shortcuts
- Small pills: `bg-2`, `border`, mono caption text.
- Platform-adaptive: `⌘` on macOS, `Ctrl` on Windows/Linux.
- Examples: `⌘K`, `N`, `T`, `↵`, `ESC`

*Last updated: May 2026*

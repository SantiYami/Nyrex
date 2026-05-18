# Nyrex — Screen: Authentication Gateway (Stage 1)

> Secure local entry. Fast, minimal, trust-oriented. No navigation chrome.

## Layout

Centered card on `#0F0F14`. Max-width `400px`. Border radius `r16`. Bg `#1A1A24`.

## Content Structure

### Header
- Shield icon `#7C6AF7` (48px)
- Title: `NYREX`
- Subtitle: `Local Workspace · End-to-End Encrypted`

### Form Fields
| Field | Type | Notes |
|-------|------|-------|
| Email | Optional text | For key recovery/sync only |
| Master Password | Required, masked | Reveal toggle eye icon. ≥8 chars to enable submit |
| Biometric | Secondary button | Fingerprint/face icon. Mobile only |

### Actions
| Action | Style | Notes |
|--------|-------|-------|
| `Unlock` | Primary (`#7C6AF7`) | Full-width. Disabled until ≥8 chars |
| `Reset Local Data` | Ghost, `#FF5C5C` text | Bottom-right. Destructive — confirmation dialog required |

### Footer
`v1.0 · Offline Ready · Zero Telemetry`

## States

| State | Behavior |
|-------|----------|
| **Default** | Focus on password field. Submit enabled when ≥8 chars |
| **Loading** | Button shows inline spinner. Inputs disabled. Shield pulses subtly |
| **Error** | Border `#FF5C5C`, helper text `"Invalid master key."`, shake animation (3 frames) |
| **Success** | 150ms crossfade to Dashboard via `AnimatedSwitcher`. No hard cut |

## Flutter Mapping

| Element | Widget | Notes |
|---------|--------|-------|
| Card | `Center` + `Container(BoxDecoration)` | border, r16, bg-1 |
| Fields | `TextFormField` + custom `InputDecoration` | Use `NxInput` atom |
| Unlock | `NxButton(variant: primary)` | Full-width, loading state |
| Transition | `AnimatedSwitcher` / `PageRouteBuilder` | 150ms, `Curves.easeOut` |

*Last updated: May 2026*

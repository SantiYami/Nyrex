# Nyrex — Screen: Empty State & Onboarding (Stage 1)

> First launch or cleared workspace. Welcoming, operational, not technical.

## Layout

Full-screen `#0F0F14`. Centered content. No navigation chrome (no rail, no sidebar).

## Content

### Visual
- Icon: minimal shield + terminal cursor `>_` — color `#555568`
- Title: `Workspace Initialized`
- Subtitle: `No operations pending. Configure your environment to begin.`

### Actions
| Action | Style |
|--------|-------|
| `Run Setup Wizard` | Primary `NxButton` |
| `Import Data` | Secondary `NxButton` |
| `Start Blank` | Ghost `NxButton` |

### Footer
`v1.0 · Local Encryption Active · Offline Ready`

## Setup Wizard Flow (Optional)

| Step | Content |
|------|---------|
| 1 | Choose theme: Dark / Light / AMOLED |
| 2 | Set vault master password + confirmation |
| 3 | Create first note (optional, skip available) |
| 4 | Complete → crossfade to Dashboard |

Uses `NxWizardStepper` molecule.

## Per-Module Empty States

Each module provides its own `NxEmptyState` content:

| Module | Icon | Message | CTA |
|--------|------|---------|-----|
| Notes | `edit_note` | `No notes yet. Start writing.` | `+ New Note` |
| Vault | `lock` | `Vault is empty. Add your first credential.` | `+ Add Entry` |
| Tasks | `check_circle` | `Nothing pending. Capture a task.` | `+ New Task` |
| Finance | `wallet` | `No budget configured. Set up your finances.` | `Start Budget Wizard` |

*Last updated: May 2026*

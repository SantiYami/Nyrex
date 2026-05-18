# Nyrex v1.0 — Module: Finance (Stage 5)

> Budget management, debt tracking (3 types), savings goals, quick expense entry, and dashboard.

---

## Module Path

```
modules/finance/
├── data/
│   ├── datasources/
│   │   └── finance_local_datasource.dart
│   ├── models/
│   │   ├── budget_model.dart
│   │   ├── budget_item_model.dart
│   │   ├── category_model.dart
│   │   ├── debt_model.dart
│   │   └── savings_account_model.dart
│   └── repositories/
│       └── finance_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── budget.dart           # Freezed: id, month, income, template_id
│   │   ├── budget_item.dart      # category, planned, spent, is_active
│   │   ├── category.dart         # name, icon, color, type(fixed|variable)
│   │   ├── debt.dart             # polymorphic: credit_card|bank_loan|personal_loan
│   │   └── savings_account.dart  # target, current, monthly_contribution
│   └── repositories/
│       └── finance_repository.dart
└── presentation/
    ├── providers/
    │   ├── finance_dashboard_provider.dart
    │   ├── budget_wizard_provider.dart
    │   ├── debt_provider.dart
    │   └── savings_provider.dart
    ├── screens/
    │   ├── finance_dashboard_screen.dart
    │   ├── budget_wizard_screen.dart
    │   ├── debt_detail_screen.dart
    │   ├── savings_screen.dart
    │   └── finance_quick_entry_screen.dart
    └── widgets/
        ├── cash_flow_widget.dart
        ├── budget_item_card.dart       # Uses NxItemCard
        ├── credit_limit_bar.dart       # Semantic color by %
        ├── debt_kind_badge.dart        # personal_loan|bank_loan|credit_card
        ├── savings_progress_bar.dart
        └── finance_quick_entry_sheet.dart
```

---

## Data Model (Local SQLite)

```sql
finance_categories (
  id    TEXT PRIMARY KEY,
  name  TEXT NOT NULL,
  icon  TEXT,
  color TEXT,
  type  TEXT DEFAULT 'variable'  -- fixed|variable
)

budgets (
  id          TEXT PRIMARY KEY,
  month       INTEGER NOT NULL,  -- YYYYMM format
  income      REAL NOT NULL,
  template_id TEXT,
  created_at  INTEGER,
  sync_status TEXT DEFAULT 'pending'
)

budget_items (
  id          TEXT PRIMARY KEY,
  budget_id   TEXT REFERENCES budgets(id),
  category_id TEXT REFERENCES finance_categories(id),
  planned     REAL NOT NULL,
  spent       REAL DEFAULT 0,
  is_active   INTEGER DEFAULT 1,
  sort_order  INTEGER
)

debts (
  id            TEXT PRIMARY KEY,
  kind          TEXT NOT NULL,    -- credit_card|bank_loan|personal_loan
  name          TEXT NOT NULL,
  total_amount  REAL NOT NULL,
  remaining     REAL NOT NULL,
  interest_rate REAL,
  credit_limit  REAL,            -- credit_card only
  monthly_payment REAL,
  due_day       INTEGER,
  vault_entry_id TEXT,           -- optional link to vault for sensitive data
  created_at    INTEGER,
  sync_status   TEXT DEFAULT 'pending'
)

savings_accounts (
  id                    TEXT PRIMARY KEY,
  name                  TEXT NOT NULL,
  target_amount         REAL NOT NULL,
  current_amount        REAL DEFAULT 0,
  monthly_contribution  REAL DEFAULT 0,
  created_at            INTEGER,
  sync_status           TEXT DEFAULT 'pending'
)
```

---

## User Stories

### S5.1 — Finance Dashboard

> *As a user, I want a dashboard with cash flow, budget summary, debts, savings, and quick actions.*

- **Desktop:** 3-column grid. **Mobile:** stacked cards.
- Hero amount: net cash flow using `NxMoneyDisplay` (tabular-nums).
- Active budget summary: income vs total spent, health indicator (green/yellow/red).
- Budget item list: `NxItemCard` per item with planned/spent/progress.
- Collapsible sections: Debts, Savings.
- Quick action FAB: "Log Expense", "New Budget", "Add Debt".

**Acceptance:** Dashboard renders with real data. Layout adapts across breakpoints.

### S5.2 — Budget Wizard (5 Steps)

> *As a user, I want a guided wizard to create a monthly budget.*

| Step | Content |
|------|---------|
| 1. Income | Enter total monthly income |
| 2. Fixed Expenses | Add/edit fixed items (rent, insurance, subscriptions) |
| 3. Variable Categories | Allocate remaining to food, transport, entertainment, etc. |
| 4. Savings Allocation | Set aside amount for savings goals |
| 5. Review | Summary with health traffic light per category |

- `NxWizardStepper`: active=violet underline, completed=teal check.
- Smart suggestions: pre-fill from previous month's budget.
- Health indicator per category: green (<60%), yellow (60-80%), red (>80%) of income.
- Save creates budget + all budget_items in single transaction.

**Acceptance:** Wizard completes end-to-end. Budget and items saved to local DB.

### S5.3 — Debt Tracking (Polymorphic)

> *As a user, I want to track credit cards, bank loans, and personal loans with type-specific UI.*

| Debt Kind | Specific UI |
|-----------|-------------|
| `credit_card` | `CreditLimitBar`: used/limit, color by % (<30% green, 30-70% yellow, >70% red) |
| `bank_loan` | Amortization schedule preview, remaining/total, monthly payment |
| `personal_loan` | Simple: owed to whom, remaining, no interest |

- `DebtKindBadge` atom: small chip with icon + label per kind.
- Detail view adapts layout based on `kind`.
- Optional link to vault entry for card numbers / contract data.

**Acceptance:** All three debt types CRUD correctly. UI adapts per kind.

### S5.4 — Quick Entry (Free & From-Item)

> *As a user, I want to log an expense quickly.*

**Free mode** (3 steps):
1. Enter amount (numeric keypad).
2. Select category (grid of category icons).
3. Confirm (optional note).

**From-item mode** (1 tap):
- Tap `▶` on a budget item card → pre-filled with category + last amount.
- Single tap to confirm.

- `NxFinanceQuickEntry` organism: bottom sheet (mobile) / modal (web).
- On save: teal chip feedback, dashboard updates instantly (local write).

**Acceptance:** Both modes save to local DB. Dashboard reflects change immediately.

### S5.5 — Savings Goals

> *As a user, I want savings goals with targets and visual progress.*

- Create account: name, target amount, monthly contribution.
- Progress bar: current/target with percentage.
- Log contribution: quick amount entry.
- Dashboard card: shows all savings with combined progress.

**Acceptance:** CRUD works. Progress bar updates on contribution.

### S5.6 — Cross-Module Integration

> *As a user, I want finance linked to notes, tasks, and vault.*

| Integration | Mechanism |
|-------------|-----------|
| Notes → Finance | `/expense [amount]` slash command opens Quick Entry pre-linked to note |
| Tasks → Finance | Budget item action "Create reminder" generates recurring task |
| Vault → Finance | Debt detail "Link credentials" opens vault entry selector (for card numbers) |
| Finance → Notes | Expense item shows "📝 Note" link if created from a note |

**Acceptance:** All cross-module links create bidirectional references. Deleting one side removes link, not the other entity.

---

## Finance-Specific Design Rules

- All monetary amounts use `NxMoneyDisplay` (mono font, `tabularFigures()`).
- Semantic colors for status only: green=healthy, yellow=warning, red=exceeded.
- Never decorative gradients on financial data.
- Currency format: locale-aware via `intl` package.

*Last updated: May 2026*

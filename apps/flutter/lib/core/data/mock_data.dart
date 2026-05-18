// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Centralized mock data for Stage 2 UI development.
///
/// All values mirror the JSX prototype's `data.js` file.
/// This file will be replaced by real data from local SQLite
/// once each module's domain/data layers are wired up.
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Finance — Mock
// ---------------------------------------------------------------------------

class MockBudgetItem {
  const MockBudgetItem({
    required this.label,
    required this.spent,
    required this.limit,
    required this.icon,
  });

  final String label;
  final double spent;
  final double limit;
  final IconData icon;
}

class MockSavingsGoal {
  const MockSavingsGoal({
    required this.label,
    required this.current,
    required this.target,
    required this.icon,
  });

  final String label;
  final double current;
  final double target;
  final IconData icon;
}

class MockDebt {
  const MockDebt({
    required this.label,
    required this.balance,
    required this.apr,
    required this.minPayment,
  });

  final String label;
  final double balance;
  final double apr;
  final double minPayment;
}

const kMockBudgetItems = [
  MockBudgetItem(
    label: 'Groceries',
    spent: 287,
    limit: 400,
    icon: Icons.shopping_cart_outlined,
  ),
  MockBudgetItem(
    label: 'Subscriptions',
    spent: 64,
    limit: 80,
    icon: Icons.subscriptions_outlined,
  ),
  MockBudgetItem(
    label: 'Transport',
    spent: 112,
    limit: 150,
    icon: Icons.directions_car_outlined,
  ),
  MockBudgetItem(
    label: 'Dining Out',
    spent: 95,
    limit: 120,
    icon: Icons.restaurant_outlined,
  ),
];

const kMockSavingsGoals = [
  MockSavingsGoal(
    label: 'Emergency Fund',
    current: 8400,
    target: 15000,
    icon: Icons.shield_outlined,
  ),
  MockSavingsGoal(
    label: 'Vacation',
    current: 2100,
    target: 5000,
    icon: Icons.flight_outlined,
  ),
  MockSavingsGoal(
    label: 'New Laptop',
    current: 1850,
    target: 2500,
    icon: Icons.laptop_outlined,
  ),
];

const kMockDebts = [
  MockDebt(label: 'Student Loan', balance: 18420, apr: 5.5, minPayment: 285),
  MockDebt(label: 'Credit Card', balance: 2340, apr: 19.9, minPayment: 65),
];

// ---------------------------------------------------------------------------
// Cash Flow — Sparkline points (last 7 days)
// ---------------------------------------------------------------------------

const kMockCashFlowPoints = [
  4200.0,
  3800.0,
  4100.0,
  3950.0,
  4400.0,
  4150.0,
  4680.0,
];
const kMockCashFlowLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

// ---------------------------------------------------------------------------
// Tasks — Mock
// ---------------------------------------------------------------------------

class MockTask {
  const MockTask({
    required this.title,
    required this.project,
    required this.projectColor,
    this.priority = MockPriority.medium,
    this.isCompleted = false,
    this.dueLabel,
    this.tags = const [],
    this.group = 'TODAY',
  });

  final String title;
  final String project;
  final Color projectColor;
  final MockPriority priority;
  final bool isCompleted;
  final String? dueLabel;
  final List<String> tags;
  final String group;
}

enum MockPriority {
  critical(Color(0xFFFF5C5C)),
  high(Color(0xFFFFC947)),
  medium(Color(0xFF4DA6FF)),
  low(Color(0xFF555568));

  const MockPriority(this.color);
  final Color color;
}

const _violet = Color(0xFF7C6AF7);
const _blue = Color(0xFF4DA6FF);
const _gray = Color(0xFF555568);

const kMockTasks = [
  MockTask(
    title: 'Fix auth token refresh loop',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.critical,
    dueLabel: 'Yesterday',
    tags: ['#bug', '#backend'],
    group: 'OVERDUE',
  ),
  MockTask(
    title: 'Review PR #47 — drift migration',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.high,
    dueLabel: 'Today',
    tags: ['#review'],
    group: 'TODAY',
  ),
  MockTask(
    title: 'Write sync layer unit tests',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.medium,
    dueLabel: 'Today',
    tags: ['#testing'],
    group: 'TODAY',
  ),
  MockTask(
    title: 'Update Docker compose for staging',
    project: 'Infra',
    projectColor: _blue,
    priority: MockPriority.medium,
    dueLabel: 'Tomorrow',
    tags: ['#devops'],
    group: 'TOMORROW',
  ),
  MockTask(
    title: 'Design settings page wireframes',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.low,
    dueLabel: 'May 12',
    tags: ['#design'],
    group: 'UPCOMING',
  ),
  MockTask(
    title: 'Research offline-first CRDT libraries',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.medium,
    tags: [],
    group: 'NO DATE',
  ),
  MockTask(
    title: 'Renew domain nyrex.dev',
    project: 'Personal',
    projectColor: _gray,
    tags: ['#admin'],
    group: 'NO DATE',
  ),
  MockTask(
    title: 'Set up Meilisearch instance',
    project: 'Infra',
    projectColor: _blue,
    priority: MockPriority.medium,
    isCompleted: true,
    tags: ['#devops'],
    group: 'COMPLETED',
  ),
  MockTask(
    title: 'Implement vault encryption pipeline',
    project: 'Nyrex',
    projectColor: _violet,
    priority: MockPriority.high,
    isCompleted: true,
    tags: ['#crypto'],
    group: 'COMPLETED',
  ),
];

// ---------------------------------------------------------------------------
// Notes — Mock
// ---------------------------------------------------------------------------

class MockNote {
  const MockNote({
    required this.title,
    required this.folder,
    this.isPinned = false,
    this.previewLine = '',
    this.updatedLabel = '',
  });

  final String title;
  final String folder;
  final bool isPinned;
  final String previewLine;
  final String updatedLabel;
}

const kMockNotes = [
  MockNote(
    title: 'Architecture / Nyrex sync layer',
    folder: 'Nyrex',
    isPinned: true,
    previewLine: 'CRDT-based conflict resolution with event log...',
    updatedLabel: '2h ago',
  ),
  MockNote(
    title: 'API design decisions',
    folder: 'Nyrex',
    isPinned: true,
    previewLine: 'REST vs gRPC comparison for mobile clients...',
    updatedLabel: '5h ago',
  ),
  MockNote(
    title: 'Daily standup — May 7',
    folder: 'Daily',
    previewLine: 'Blocked on auth token refresh. Sync tests pass...',
    updatedLabel: '1d ago',
  ),
  MockNote(
    title: 'K8s cluster setup notes',
    folder: 'Infra',
    previewLine: 'Using k3s for staging, Terraform for prod...',
    updatedLabel: '3d ago',
  ),
  MockNote(
    title: 'Reading: Designing Data-Intensive Apps',
    folder: 'Reading',
    previewLine: 'Ch.5 — Replication models and consistency...',
    updatedLabel: '1w ago',
  ),
  MockNote(
    title: 'Personal journal — April review',
    folder: 'Personal',
    previewLine: 'Goals progress, habit tracker review...',
    updatedLabel: '2w ago',
  ),
  MockNote(
    title: 'Encryption protocol spec',
    folder: 'Nyrex',
    previewLine: 'AES-256-GCM envelope format, key derivation...',
    updatedLabel: '3d ago',
  ),
];

// ---------------------------------------------------------------------------
// Vault — Mock entries
// ---------------------------------------------------------------------------

class MockVaultEntry {
  const MockVaultEntry({
    required this.name,
    required this.url,
    required this.kind,
    this.username = '',
    this.isCritical = false,
    this.tags = const [],
    this.faviconAbbrev = '',
  });

  final String name;
  final String url;
  final String kind;
  final String username;
  final bool isCritical;
  final List<String> tags;
  final String faviconAbbrev;
}

const kMockVaultEntries = [
  MockVaultEntry(
    name: 'GitHub',
    url: 'github.com',
    kind: 'Login',
    username: 'devon@nyrex.dev',
    isCritical: true,
    tags: ['#critical', '#code'],
    faviconAbbrev: 'GH',
  ),
  MockVaultEntry(
    name: 'AWS Console',
    url: 'console.aws.amazon.com',
    kind: 'Login',
    username: 'admin@nyrex.dev',
    isCritical: true,
    tags: ['#critical', '#infra'],
    faviconAbbrev: 'AW',
  ),
  MockVaultEntry(
    name: 'Cloudflare',
    url: 'dash.cloudflare.com',
    kind: 'Login',
    username: 'devon@nyrex.dev',
    tags: ['#infra'],
    faviconAbbrev: 'CF',
  ),
  MockVaultEntry(
    name: 'Figma',
    url: 'figma.com',
    kind: 'SSO',
    username: 'devon@nyrex.dev',
    tags: ['#work'],
    faviconAbbrev: 'FG',
  ),
  MockVaultEntry(
    name: 'Stripe Dashboard',
    url: 'dashboard.stripe.com',
    kind: 'Login',
    username: 'finance@nyrex.dev',
    isCritical: true,
    tags: ['#critical', '#finance'],
    faviconAbbrev: 'ST',
  ),
  MockVaultEntry(
    name: 'Personal Visa ••4827',
    url: '',
    kind: 'Card',
    tags: ['#finance'],
    faviconAbbrev: '💳',
  ),
  MockVaultEntry(
    name: 'SSH Key — prod-server',
    url: '',
    kind: 'Secure Note',
    tags: ['#infra', '#critical'],
    faviconAbbrev: '🔑',
  ),
  MockVaultEntry(
    name: 'Google Workspace',
    url: 'workspace.google.com',
    kind: 'SSO',
    username: 'devon@nyrex.dev',
    tags: ['#work'],
    faviconAbbrev: 'GW',
  ),
];

// ---------------------------------------------------------------------------
// Home Dashboard — Agenda mock
// ---------------------------------------------------------------------------

class MockAgendaItem {
  const MockAgendaItem({
    required this.time,
    required this.title,
    required this.type,
  });

  final String time;
  final String title;
  final String type; // 'meeting', 'focus', 'deadline'
}

const kMockAgenda = [
  MockAgendaItem(time: '09:00', title: 'Daily standup', type: 'meeting'),
  MockAgendaItem(
    time: '10:00 – 12:00',
    title: 'Deep work — sync engine',
    type: 'focus',
  ),
  MockAgendaItem(
    time: '13:00',
    title: 'Design review with team',
    type: 'meeting',
  ),
  MockAgendaItem(
    time: '14:30',
    title: 'PR deadline — drift migration',
    type: 'deadline',
  ),
  MockAgendaItem(
    time: '15:00 – 17:00',
    title: 'Deep work — vault UI',
    type: 'focus',
  ),
  MockAgendaItem(time: '17:30', title: '1:1 with Alex', type: 'meeting'),
];

// ---------------------------------------------------------------------------
// Command Palette — Mock index
// ---------------------------------------------------------------------------

class MockCommandEntry {
  const MockCommandEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.group,
    this.shortcut,
    this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String group;
  final String? shortcut;
  final String? route;
}

const kMockCommandIndex = [
  MockCommandEntry(
    title: 'New Note',
    subtitle: 'Create a new encrypted note',
    icon: Icons.note_add_outlined,
    group: 'QUICK ACTIONS',
    shortcut: '⌘N',
    route: '/notes/edit',
  ),
  MockCommandEntry(
    title: 'New Vault Entry',
    subtitle: 'Add a new credential',
    icon: Icons.lock_outlined,
    group: 'QUICK ACTIONS',
    route: '/vault',
  ),
  MockCommandEntry(
    title: 'Quick Capture Task',
    subtitle: 'Add a task via quick input',
    icon: Icons.add_task_outlined,
    group: 'QUICK ACTIONS',
    route: '/tasks',
  ),
  MockCommandEntry(
    title: 'Log Expense',
    subtitle: 'Record a new transaction',
    icon: Icons.receipt_long_outlined,
    group: 'QUICK ACTIONS',
    shortcut: '⌘E',
    route: '/finance',
  ),
  MockCommandEntry(
    title: 'Home',
    subtitle: 'Dashboard overview',
    icon: Icons.home_outlined,
    group: 'MODULES',
    shortcut: '1',
    route: '/home',
  ),
  MockCommandEntry(
    title: 'Notes',
    subtitle: 'Encrypted markdown notes',
    icon: Icons.edit_note_outlined,
    group: 'MODULES',
    shortcut: '2',
    route: '/notes',
  ),
  MockCommandEntry(
    title: 'Vault',
    subtitle: 'Credential manager',
    icon: Icons.lock_outlined,
    group: 'MODULES',
    shortcut: '3',
    route: '/vault',
  ),
  MockCommandEntry(
    title: 'Tasks',
    subtitle: 'Task & project tracker',
    icon: Icons.check_circle_outline,
    group: 'MODULES',
    shortcut: '4',
    route: '/tasks',
  ),
  MockCommandEntry(
    title: 'Finance',
    subtitle: 'Budget & expense tracking',
    icon: Icons.account_balance_wallet_outlined,
    group: 'MODULES',
    shortcut: '5',
    route: '/finance',
  ),
  MockCommandEntry(
    title: 'Toggle Focus Mode',
    subtitle: 'Hide sidebar and dim rail',
    icon: Icons.center_focus_strong_outlined,
    group: 'COMMANDS',
    shortcut: '⌘⇧F',
  ),
];

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// HomeDashboardPage — Three-column grid layout dashboard.
///
/// Columns:
///   1: Financial Pulse + Cash Flow chart + Unified Agenda
///   2: Budget Items + Savings Goals + Debt Exposure
///   3: Quick Actions + Focus Tasks + Recent Notes + System
///
/// All data is hardcoded mock. Finance cards use mock data since
/// Finance module is deferred to Stage 5.
library;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nyrex/core/data/mock_data.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/design_system/layouts/layouts.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyrex/design_system/theme/app_theme.dart';
import 'package:nyrex/design_system/theme/theme_provider.dart';

class HomeDashboardPage extends ConsumerWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          _buildGreeting(context, ref),
          const SizedBox(height: kSpace2xl),
          // Desktop 3-column grid via NxDashboardLayout
          NxDashboardLayout(
            columns: [_column1(context), _column2(context), _column3(context)],
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;
    if (hour < 12) {
      greeting = l10n.greetingMorning;
    } else if (hour < 17) {
      greeting = l10n.greetingAfternoon;
    } else {
      greeting = l10n.greetingEvening;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.dashSystemLabel} / ${_formatDate(now)}',
              style: nxMonoSm().copyWith(
                color: c.textLow,
                fontWeight: kWeightMedium,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: kSpaceSm),
            Text(
              '$greeting, devon.',
              style: nxDisplay().copyWith(color: c.textHigh),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            ref.watch(themeProvider).isDark
                ? Icons.light_mode
                : Icons.dark_mode,
            color: c.textMedium,
          ),
          onPressed: () {
            final isDark = ref.read(themeProvider).isDark;
            ref
                .read(themeProvider.notifier)
                .setVariant(
                  isDark ? NyrexThemeVariant.light : NyrexThemeVariant.dark,
                );
          },
        ),
      ],
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${months[d.month - 1]} ${d.day} · $h:$m';
  }

  // -------------------------------------------------------------------------
  // Column 1: Financial Pulse + Cash Flow + Agenda
  // -------------------------------------------------------------------------

  Widget _column1(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);
    return Column(
      children: [
        NxDashCard(
          title: l10n.dashFinancialPulse,
          child: Column(
            children: [
              _pulseRow(context, l10n.dashNetWorth, '\$42,680', c.confirmation),
              _pulseRow(context, l10n.dashMonthlyBurn, '\$3,240', c.warning),
              _pulseRow(context, l10n.dashSavingsRate, '28%', c.primary),
            ],
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashCashFlow,
          child: SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      kMockCashFlowPoints.length,
                      (i) => FlSpot(i.toDouble(), kMockCashFlowPoints[i]),
                    ),
                    isCurved: true,
                    color: c.primary,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: c.primary.withAlpha(25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashUnifiedAgenda,
          child: Column(
            children: kMockAgenda.map((a) {
              IconData icon;
              Color dotColor;
              switch (a.type) {
                case 'meeting':
                  icon = Icons.groups_outlined;
                  dotColor = c.primary;
                case 'focus':
                  icon = Icons.center_focus_strong_outlined;
                  dotColor = c.confirmation;
                case 'deadline':
                  icon = Icons.flag_outlined;
                  dotColor = c.error;
                default:
                  icon = Icons.event;
                  dotColor = c.textLow;
              }
              return NxAgendaRow(
                time: a.time,
                title: a.title,
                dotColor: dotColor,
                trailingIcon: icon,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _pulseRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    final c = NxColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: nxSecondary().copyWith(color: c.textMedium)),
          Text(value, style: nxMonoLg().copyWith(color: color)),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Column 2: Budget Items + Savings Goals + Debt Exposure
  // -------------------------------------------------------------------------

  Widget _column2(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);
    return Column(
      children: [
        NxDashCard(
          title: l10n.dashBudgetItems,
          child: Column(
            children: kMockBudgetItems.map((b) {
              final pct = b.spent / b.limit;
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(b.icon, size: 14, color: c.textLow),
                        const SizedBox(width: kSpaceSm),
                        Expanded(
                          child: Text(
                            b.label,
                            style: nxSecondary().copyWith(color: c.textMedium),
                          ),
                        ),
                        Text(
                          '\$${b.spent.toInt()} / \$${b.limit.toInt()}',
                          style: nxMonoCap().copyWith(
                            color: pct > 0.9 ? c.error : c.textLow,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpaceXs),
                    NxProgressBar(
                      value: pct.clamp(0.0, 1.0),
                      color: pct > 0.9
                          ? c.error
                          : pct > 0.7
                          ? c.warning
                          : c.primary,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashSavingsGoals,
          child: Column(
            children: kMockSavingsGoals.map((s) {
              final pct = s.current / s.target;
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(s.icon, size: 14, color: c.textLow),
                        const SizedBox(width: kSpaceSm),
                        Expanded(
                          child: Text(
                            s.label,
                            style: nxSecondary().copyWith(color: c.textMedium),
                          ),
                        ),
                        Text(
                          '${(pct * 100).toInt()}%',
                          style: nxMonoCap().copyWith(color: c.confirmation),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpaceXs),
                    NxProgressBar(
                      value: pct.clamp(0.0, 1.0),
                      color: c.confirmation,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashDebtExposure,
          child: Column(
            children: kMockDebts.map((d) {
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpaceMd),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.label,
                            style: nxSecondary().copyWith(color: c.textMedium),
                          ),
                          Text(
                            '${d.apr}% APR · \$${d.minPayment.toInt()}/mo min',
                            style: nxMonoSm().copyWith(color: c.textLow),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${d.balance.toStringAsFixed(0)}',
                      style: nxMonoLg().copyWith(color: c.error),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Column 3: Quick Actions + Focus Tasks + Recent Notes + System
  // -------------------------------------------------------------------------

  Widget _column3(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);
    return Column(
      children: [
        NxDashCard(
          title: l10n.dashQuickActions,
          child: Wrap(
            spacing: kSpaceSm,
            runSpacing: kSpaceSm,
            children: [
              NxActionChip(
                icon: Icons.note_add_outlined,
                label: l10n.dashNewNote,
              ),
              NxActionChip(icon: Icons.lock_outlined, label: l10n.dashNewEntry),
              NxActionChip(
                icon: Icons.add_task_outlined,
                label: l10n.dashAddTask,
              ),
              NxActionChip(
                icon: Icons.receipt_long_outlined,
                label: l10n.dashLogExpense,
              ),
            ],
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashFocusTasks,
          child: Column(
            children: kMockTasks
                .where((t) => t.group == 'TODAY' || t.group == 'OVERDUE')
                .take(3)
                .map((t) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: kSpaceSm),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: t.priority.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: kSpaceSm),
                        Expanded(
                          child: Text(
                            t.title,
                            style: nxSecondary().copyWith(color: c.textMedium),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (t.dueLabel != null)
                          Text(
                            t.dueLabel!,
                            style: nxMonoSm().copyWith(
                              color: t.group == 'OVERDUE' ? c.error : c.textLow,
                            ),
                          ),
                      ],
                    ),
                  );
                })
                .toList(),
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashRecentNotes,
          child: Column(
            children: kMockNotes.take(3).map((n) {
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpaceSm),
                child: Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 14,
                      color: c.textLow,
                    ),
                    const SizedBox(width: kSpaceSm),
                    Expanded(
                      child: Text(
                        n.title,
                        style: nxSecondary().copyWith(color: c.textMedium),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      n.updatedLabel,
                      style: nxMonoSm().copyWith(color: c.textLow),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: kSpaceLg),
        NxDashCard(
          title: l10n.dashSystem,
          child: Column(
            children: [
              NxMetaRow(
                label: l10n.dashStorage,
                value: 'SQLite · 2.4 MB',
                bottomSpacing: kSpaceSm,
              ),
              NxMetaRow(
                label: l10n.dashSync,
                value: 'Connected · Last 3m ago',
                bottomSpacing: kSpaceSm,
              ),
              NxMetaRow(
                label: l10n.dashEncryption,
                value: 'AES-256-GCM',
                bottomSpacing: kSpaceSm,
              ),
              NxMetaRow(
                label: l10n.dashVersion,
                value: 'v1.0.0-alpha',
                bottomSpacing: kSpaceSm,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

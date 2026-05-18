// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// TasksSidebar — sidebar content for the Tasks module.
///
/// Shows: TASKS header with count, + Quick capture button,
/// Views (Today, Upcoming, All, Completed with counts),
/// Projects with color dots.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class TasksSidebar extends StatelessWidget {
  const TasksSidebar({
    super.key,
    this.onSearchTap,
    this.onQuickCaptureTap,
    this.activeView,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onQuickCaptureTap;
  final String? activeView;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(kSpaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'TASKS',
                    style: nxSecondary().copyWith(
                      color: c.textHigh,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                  const SizedBox(width: kSpaceSm),
                  Text('07', style: nxMonoCap().copyWith(color: c.textLow)),
                ],
              ),
              const SizedBox(height: kSpaceLg),
              NxSearchBar(onTap: onSearchTap),
              const SizedBox(height: kSpaceMd),
              NxButton(
                label: l10n.actionQuickCapture,
                variant: NxButtonVariant.secondary,
                onPressed: onQuickCaptureTap,
              ),
            ],
          ),
        ),

        // Views & Projects
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceSm),
            children: [
              NxNavGroup(
                title: l10n.navViews,
                items: [
                  NxNavItem(
                    label: l10n.viewToday,
                    isActive: activeView == 'Today' || activeView == null,
                    onTap: () {},
                    trailing: _countBadge('3'),
                  ),
                  NxNavItem(
                    label: l10n.viewUpcoming,
                    isActive: activeView == 'Upcoming',
                    onTap: () {},
                    trailing: _countBadge('2'),
                  ),
                  NxNavItem(
                    label: l10n.viewAll,
                    isActive: activeView == 'All',
                    onTap: () {},
                    trailing: _countBadge('7'),
                  ),
                  NxNavItem(
                    label: l10n.viewCompleted,
                    isActive: activeView == 'Completed',
                    onTap: () {},
                    trailing: _countBadge('2'),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceMd),
              NxNavGroup(
                title: l10n.navProjects,
                items: [
                  NxNavItem(
                    label: 'Nyrex',
                    onTap: () {},
                    leading: _projectDot(const Color(0xFF7C6AF7)),
                  ),
                  NxNavItem(
                    label: 'Infra',
                    onTap: () {},
                    leading: _projectDot(const Color(0xFF4DA6FF)),
                  ),
                  NxNavItem(
                    label: 'Personal',
                    onTap: () {},
                    leading: _projectDot(const Color(0xFF555568)),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Footer
        Container(
          padding: const EdgeInsets.all(kSpaceMd),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: c.divider, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'devon · local · encrypted',
                  style: nxMonoSm().copyWith(color: c.textLow),
                ),
              ),
              Icon(Icons.more_horiz, size: 14, color: c.textLow),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _countBadge(String count) {
    return Builder(
      builder: (context) {
        final c = NxColors.of(context);
        return Text(count, style: nxMonoCap().copyWith(color: c.textLow));
      },
    );
  }

  static Widget _projectDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

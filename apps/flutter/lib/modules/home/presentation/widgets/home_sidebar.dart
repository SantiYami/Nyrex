// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// HomeSidebar — sidebar content for the Home/Dashboard module.
///
/// Sections: TODAY (Studio, Focus list, Agenda), PINNED, MODULES.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class HomeSidebar extends StatelessWidget {
  const HomeSidebar({
    super.key,
    this.onSearchTap,
    this.onQuickCaptureTap,
    this.onNavigate,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onQuickCaptureTap;
  final void Function(String route)? onNavigate;

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
              // Title — no count for Home
              Text(
                l10n.navHome,
                style: nxSecondary().copyWith(
                  color: c.textHigh,
                  fontWeight: kWeightSemiBold,
                ),
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

        // Nav sections
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceSm),
            children: [
              NxNavGroup(
                title: l10n.navToday,
                items: [
                  NxNavItem(
                    label: l10n.moduleStudio,
                    isActive: true,
                    onTap: () {},
                  ),
                  NxNavItem(
                    label: l10n.moduleFocusList,
                    onTap: () {},
                    trailing: _countBadge('3'),
                  ),
                  NxNavItem(
                    label: l10n.moduleAgenda,
                    onTap: () {},
                    trailing: _countBadge('6'),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceSm),
              NxNavGroup(
                title: l10n.navPinned,
                items: [
                  NxNavItem(
                    label: 'Sync layer arch',
                    onTap: () => onNavigate?.call('/notes'),
                  ),
                  NxNavItem(
                    label: 'API decisions',
                    onTap: () => onNavigate?.call('/notes'),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceSm),
              NxNavGroup(
                title: l10n.navModules,
                items: [
                  NxNavItem(
                    label: l10n.moduleNotes,
                    onTap: () => onNavigate?.call('/notes'),
                    trailing: _countBadge('7'),
                  ),
                  NxNavItem(
                    label: l10n.moduleVault,
                    onTap: () => onNavigate?.call('/vault'),
                    trailing: _countBadge('8'),
                  ),
                  NxNavItem(
                    label: l10n.moduleTasks,
                    onTap: () => onNavigate?.call('/tasks'),
                    trailing: _countBadge('7'),
                  ),
                  NxNavItem(
                    label: l10n.moduleFinance,
                    onTap: () => onNavigate?.call('/finance'),
                    trailing: _countBadge('10'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Footer
        _userFooter(),
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

  static Widget _userFooter() {
    return Builder(
      builder: (context) {
        final c = NxColors.of(context);
        return Container(
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
        );
      },
    );
  }
}

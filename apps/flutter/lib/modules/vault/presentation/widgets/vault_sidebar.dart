// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// VaultSidebar — sidebar content for the Vault module.
///
/// Shows: VAULT 08 header, SYNCED badge, + New entry button,
/// Categories (Logins, Cards, Secure notes, SSO),
/// Tags (#critical, #infra, #finance, #work, #code),
/// Footer: AES-256 · LOCAL ONLY, AUTO-LOCK 5m.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class VaultSidebar extends StatelessWidget {
  const VaultSidebar({
    super.key,
    this.onSearchTap,
    this.onNewEntryTap,
    this.activeCategory,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNewEntryTap;
  final String? activeCategory;

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
                    'VAULT',
                    style: nxSecondary().copyWith(
                      color: c.textHigh,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                  const SizedBox(width: kSpaceSm),
                  Text('08', style: nxMonoCap().copyWith(color: c.textLow)),
                  const Spacer(),
                  const NxSyncBadge(isSynced: true),
                ],
              ),
              const SizedBox(height: kSpaceLg),
              NxSearchBar(onTap: onSearchTap),
              const SizedBox(height: kSpaceMd),
              NxButton(
                label: l10n.actionNewEntry,
                variant: NxButtonVariant.secondary,
                onPressed: onNewEntryTap,
              ),
            ],
          ),
        ),

        // Categories & Tags
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceSm),
            children: [
              NxNavGroup(
                title: l10n.navCategories,
                items: [
                  NxNavItem(
                    label: l10n.catLogins,
                    isActive: activeCategory == 'Logins',
                    onTap: () {},
                    trailing: _countBadge('6'),
                  ),
                  NxNavItem(
                    label: l10n.catCards,
                    isActive: activeCategory == 'Cards',
                    onTap: () {},
                    trailing: _countBadge('1'),
                  ),
                  NxNavItem(
                    label: l10n.catSecureNotes,
                    isActive: activeCategory == 'Secure notes',
                    onTap: () {},
                    trailing: _countBadge('1'),
                  ),
                  NxNavItem(
                    label: l10n.catSSO,
                    isActive: activeCategory == 'SSO',
                    onTap: () {},
                    trailing: _countBadge('2'),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceMd),
              NxNavGroup(
                title: l10n.navTags,
                items: [
                  NxNavItem(label: '#critical', onTap: () {}),
                  NxNavItem(label: '#infra', onTap: () {}),
                  NxNavItem(label: '#finance', onTap: () {}),
                  NxNavItem(label: '#work', onTap: () {}),
                  NxNavItem(label: '#code', onTap: () {}),
                ],
              ),
            ],
          ),
        ),

        // Security footer
        Container(
          padding: const EdgeInsets.all(kSpaceMd),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: c.divider, width: 1)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lock_outlined,
                    size: 10,
                    color: kColorConfirmation,
                  ),
                  const SizedBox(width: kSpaceXs),
                  Text(
                    'AES-256 · LOCAL ONLY',
                    style: nxMonoSm().copyWith(
                      color: kColorConfirmation,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceXs),
              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 10, color: c.textLow),
                  const SizedBox(width: kSpaceXs),
                  Text(
                    'AUTO-LOCK 5m',
                    style: nxMonoSm().copyWith(
                      color: c.textLow,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _countBadge(String count) {
    // Note: If c is needed here, we'd need context, but since it's a static method, let's remove static and pass context or refactor. Wait, in NxNavItem we can just use c.textLow if we pass it, or just use Builder.
    return Builder(
      builder: (context) {
        final c = NxColors.of(context);
        return Text(count, style: nxMonoCap().copyWith(color: c.textLow));
      },
    );
  }
}

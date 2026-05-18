// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NotesSidebar — sidebar content for the Notes module.
///
/// Shows: NOTES 07 header, SYNCED badge, + New note button,
/// PINNED section, and folder groups.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class NotesSidebar extends StatelessWidget {
  const NotesSidebar({
    super.key,
    this.onSearchTap,
    this.onNewNoteTap,
    this.activeNoteTitle,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNewNoteTap;
  final String? activeNoteTitle;

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
                    'NOTES',
                    style: nxSecondary().copyWith(
                      color: c.textHigh,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                  const SizedBox(width: kSpaceSm),
                  Text('07', style: nxMonoCap().copyWith(color: c.textLow)),
                  const Spacer(),
                  const NxSyncBadge(isSynced: true),
                ],
              ),
              const SizedBox(height: kSpaceLg),
              NxSearchBar(onTap: onSearchTap),
              const SizedBox(height: kSpaceMd),
              NxButton(
                label: l10n.actionNewNote,
                variant: NxButtonVariant.secondary,
                onPressed: onNewNoteTap,
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
                title: l10n.navPinned,
                items: [
                  NxNavItem(
                    label: 'Sync layer arch',
                    isActive: activeNoteTitle == 'Sync layer arch',
                    onTap: () {},
                  ),
                  NxNavItem(
                    label: 'API decisions',
                    isActive: activeNoteTitle == 'API decisions',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: kSpaceSm),
              _folderGroup('Nyrex', [
                'Sync layer arch',
                'API decisions',
                'Encryption spec',
              ]),
              const SizedBox(height: kSpaceSm),
              _folderGroup('Daily', ['Standup — May 7']),
              const SizedBox(height: kSpaceSm),
              _folderGroup('Infra', ['K8s cluster notes']),
              const SizedBox(height: kSpaceSm),
              _folderGroup('Reading', ['Data-Intensive Apps']),
              const SizedBox(height: kSpaceSm),
              _folderGroup('Personal', ['April review']),
            ],
          ),
        ),

        // Footer
        _userFooter(),
      ],
    );
  }

  NxNavGroup _folderGroup(String folder, List<String> notes) {
    return NxNavGroup(
      title: folder,
      items: notes
          .map(
            (n) => NxNavItem(
              label: n,
              isActive: activeNoteTitle == n,
              onTap: () {},
            ),
          )
          .toList(),
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

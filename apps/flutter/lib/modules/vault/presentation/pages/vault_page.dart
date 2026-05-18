// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// VaultPage — Two-pane layout: list (320px) + detail panel.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/core/data/mock_data.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/design_system/organisms/organisms.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final selected = kMockVaultEntries[_selectedIndex];

    // Build vault field list for the detail pane
    final fields = <NxVaultField>[
      if (selected.username.isNotEmpty)
        NxVaultField(label: 'USERNAME', value: selected.username),
      const NxVaultField(
        label: 'PASSWORD',
        value: '••••••••••••',
        isMasked: true,
      ),
      if (selected.url.isNotEmpty)
        NxVaultField(label: 'URL', value: selected.url),
      const NxVaultField(label: 'TOTP', value: '••••••', isMasked: true),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // List pane
        SizedBox(
          width: 320,
          child: NxVaultListPane(
            entries: kMockVaultEntries
                .map(
                  (e) => NxVaultEntryConfig(
                    name: e.name,
                    faviconAbbrev: e.faviconAbbrev,
                    url: e.url,
                    isCritical: e.isCritical,
                  ),
                )
                .toList(),
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
          ),
        ),
        const SizedBox(width: kSpaceLg),
        // Divider
        Container(width: 1, color: c.divider),
        const SizedBox(width: kSpaceLg),
        // Detail pane
        Expanded(
          child: NxVaultDetailPane(
            name: selected.name,
            faviconAbbrev: selected.faviconAbbrev,
            url: selected.url,
            kind: selected.kind,
            fields: fields,
            tags: selected.tags,
            metadata: const [
              NxMetaRow(label: 'Created', value: '2026-03-15 09:42'),
              NxMetaRow(label: 'Modified', value: '2026-05-07 14:23'),
              NxMetaRow(label: 'Accessed', value: '2h ago'),
            ],
            onLaunch: () {},
            onMore: () {},
            onDelete: () {},
            onFieldReveal: (_) {},
            onFieldCopy: (_) {},
          ),
        ),
      ],
    );
  }
}

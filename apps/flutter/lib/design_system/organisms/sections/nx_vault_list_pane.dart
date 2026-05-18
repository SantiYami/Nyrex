// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxVaultListPane — Scrollable list of vault entries with selection state.
///
/// Composition: Header + scrollable list of selectable entry cards.
/// Each entry shows favicon abbreviation, name, URL, and critical indicator.
/// Used in Vault screen as the left pane.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

/// Configuration for a vault entry in the list.
class NxVaultEntryConfig {
  const NxVaultEntryConfig({
    required this.name,
    required this.faviconAbbrev,
    this.url = '',
    this.isCritical = false,
  });

  final String name;
  final String faviconAbbrev;
  final String url;
  final bool isCritical;
}

/// A scrollable list pane of vault entries with selection.
class NxVaultListPane extends StatelessWidget {
  const NxVaultListPane({
    super.key,
    required this.entries,
    required this.selectedIndex,
    required this.onSelect,
    this.headerBreadcrumb,
  });

  /// List of vault entry configurations.
  final List<NxVaultEntryConfig> entries;

  /// Currently selected entry index.
  final int selectedIndex;

  /// Called when an entry is selected.
  final ValueChanged<int> onSelect;

  /// Header breadcrumb text. Falls back to localized default if null.
  final String? headerBreadcrumb;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NxSectionHeader(
          breadcrumb:
              headerBreadcrumb ??
              AppLocalizations.of(context).breadcrumbVaultAll,
        ),
        const SizedBox(height: kSpaceLg),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, i) {
              final entry = entries[i];
              final isSelected = i == selectedIndex;
              return GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: kDurationFast,
                  padding: const EdgeInsets.all(kSpaceMd),
                  margin: const EdgeInsets.only(bottom: kSpaceSm),
                  decoration: BoxDecoration(
                    color: isSelected ? kColorPrimarySoft : c.bg1,
                    borderRadius: kRadiusMd,
                    border: Border.all(
                      color: isSelected
                          ? kColorPrimary.withAlpha(40)
                          : c.border,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Favicon abbreviation
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: c.bg2,
                          borderRadius: kRadiusDefault,
                        ),
                        child: Center(
                          child: Text(
                            entry.faviconAbbrev,
                            style: nxMonoCap().copyWith(
                              color: c.textMedium,
                              fontWeight: kWeightSemiBold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: kSpaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.name,
                                    style: nxH3().copyWith(
                                      color: isSelected
                                          ? kColorAccentText
                                          : c.textHigh,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (entry.isCritical)
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: kColorError,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            if (entry.url.isNotEmpty)
                              Text(
                                entry.url,
                                style: nxCaption().copyWith(color: c.textLow),
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

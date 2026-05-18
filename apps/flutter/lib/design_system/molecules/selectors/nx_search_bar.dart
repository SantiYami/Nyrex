// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxSearchBar — Global search trigger.
///
/// Composition: NxInput + NxKbd.
/// When tapped or focused, it should ideally trigger the command palette.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class NxSearchBar extends StatelessWidget {
  const NxSearchBar({
    super.key,
    this.onTap,
    this.hintText,
    this.shortcut = '⌘K',
  });

  /// Called when the user taps the search bar.
  final VoidCallback? onTap;

  /// Placeholder text. Falls back to localized default if null.
  final String? hintText;

  /// Shortcut pill to display.
  final String shortcut;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AbsorbPointer(
          // Absorb pointer so the NxInput doesn't handle its own focus/text entry,
          // because tapping this should open the Command Palette.
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              NxInput(
                hint: hintText ?? l10n.hintSearch,
                leadingIcon: Icons.search,
              ),
              Positioned(
                right: kSpaceSm,
                child: NxKbd(label: shortcut),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

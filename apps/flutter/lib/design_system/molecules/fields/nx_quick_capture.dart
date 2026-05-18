// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxQuickCapture — Quick text input bar with hint and keyboard shortcut.
///
/// Composition: Icon + hint text + NxKbd pill.
/// Used in Tasks screen for quick task capture.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

/// A quick capture input bar with a hint and keyboard shortcut pill.
class NxQuickCapture extends StatelessWidget {
  const NxQuickCapture({
    super.key,
    this.hint,
    this.shortcut = '↵',
    this.icon = Icons.add,
    this.onTap,
    this.onSubmitted,
  });

  /// Placeholder hint text. Falls back to localized default if null.
  final String? hint;

  /// Keyboard shortcut label for the trailing pill.
  final String shortcut;

  /// Leading icon.
  final IconData icon;

  /// Called when the bar is tapped (for non-editable mode).
  final VoidCallback? onTap;

  /// Called when text is submitted (for editable mode).
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final resolvedHint = hint ?? l10n.hintQuickCapture;
    final c = NxColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceLg,
          vertical: kSpaceMd,
        ),
        decoration: BoxDecoration(
          color: c.bg1,
          borderRadius: kRadiusMd,
          border: Border.all(color: c.border, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: c.textLow),
            const SizedBox(width: kSpaceSm),
            Expanded(
              child: Text(
                resolvedHint,
                style: nxSecondary().copyWith(color: c.textLow),
              ),
            ),
            NxKbd(label: shortcut),
          ],
        ),
      ),
    );
  }
}

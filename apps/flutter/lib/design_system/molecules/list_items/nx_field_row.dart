// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxFieldRow — Labeled field row with copy/reveal actions.
///
/// Composition: Label (mono) + value (mono) + optional reveal/copy buttons.
/// Used in Vault detail pane for USERNAME, PASSWORD, URL, TOTP fields.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';

/// A labeled field row with optional reveal and copy actions.
class NxFieldRow extends StatelessWidget {
  const NxFieldRow({
    super.key,
    required this.label,
    required this.value,
    this.isMasked = false,
    this.onReveal,
    this.onCopy,
  });

  /// Field label displayed in uppercase mono font.
  final String label;

  /// Field value.
  final String value;

  /// Whether the value is masked (e.g. passwords).
  final bool isMasked;

  /// Called when the reveal/hide button is tapped.
  final VoidCallback? onReveal;

  /// Called when the copy button is tapped.
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceLg,
          vertical: kSpaceMd,
        ),
        decoration: BoxDecoration(
          color: c.bg1,
          borderRadius: kRadiusDefault,
          border: Border.all(color: c.border, width: 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: nxMonoSm().copyWith(
                  color: c.textLow,
                  fontWeight: kWeightSemiBold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: nxSecondary().copyWith(color: c.textHigh),
              ),
            ),
            if (isMasked && onReveal != null)
              NxIconButton(
                icon: Icons.visibility_outlined,
                onPressed: onReveal!,
              ),
            if (onCopy != null) ...[
              const SizedBox(width: kSpaceSm),
              NxIconButton(icon: Icons.copy_outlined, onPressed: onCopy!),
            ],
          ],
        ),
      ),
    );
  }
}

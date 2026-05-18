// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxMetaRow — Key-value metadata row.
///
/// Displays a label on the left and a monospaced value on the right.
/// Used in Vault detail (metadata section) and Home dashboard (system card).
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A key-value metadata row with label and mono value.
class NxMetaRow extends StatelessWidget {
  const NxMetaRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.bottomSpacing = kSpaceXs,
  });

  /// Display label (left-aligned).
  final String label;

  /// Display value (right-aligned, mono font).
  final String value;

  /// Optional override color for the value text.
  final Color? valueColor;

  /// Bottom spacing between rows (defaults to [kSpaceXs]).
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: nxCaption().copyWith(color: c.textLow)),
          Text(
            value,
            style: nxMonoCap().copyWith(color: valueColor ?? c.textMedium),
          ),
        ],
      ),
    );
  }
}

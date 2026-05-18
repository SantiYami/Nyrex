// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxActionChip — Small icon + label chip for quick actions.
///
/// Composition: Icon + label text inside a bordered container.
/// Used in Home Dashboard "Quick Actions" card.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A small action chip with an icon and label.
class NxActionChip extends StatelessWidget {
  const NxActionChip({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  /// Leading icon.
  final IconData icon;

  /// Chip label text.
  final String label;

  /// Called when the chip is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpaceMd,
            vertical: kSpaceSm,
          ),
          decoration: BoxDecoration(
            color: c.bg2,
            borderRadius: kRadiusDefault,
            border: Border.all(color: c.border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: c.textMedium),
              const SizedBox(width: kSpaceSm),
              Text(label, style: nxSecondary().copyWith(color: c.textMedium)),
            ],
          ),
        ),
      ),
    );
  }
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxAgendaRow — Single agenda/schedule item.
///
/// Composition: Color dot + time label (mono) + title + trailing icon.
/// Used in the Home Dashboard "Unified Agenda" card.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A single row in an agenda/schedule list.
class NxAgendaRow extends StatelessWidget {
  const NxAgendaRow({
    super.key,
    required this.time,
    required this.title,
    this.dotColor,
    this.trailingIcon,
    this.onTap,
  });

  /// Time label (e.g. `'09:00'`, `'10:00 – 12:00'`).
  final String time;

  /// Agenda item title.
  final String title;

  /// Color of the leading status dot.
  final Color? dotColor;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Called when the row is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final finalDotColor = dotColor ?? c.textLow;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSpaceSm),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: finalDotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: kSpaceSm),
            Text(time, style: nxMonoCap().copyWith(color: c.textLow)),
            const SizedBox(width: kSpaceMd),
            Expanded(
              child: Text(
                title,
                style: nxSecondary().copyWith(color: c.textMedium),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, size: 14, color: c.textLow),
          ],
        ),
      ),
    );
  }
}

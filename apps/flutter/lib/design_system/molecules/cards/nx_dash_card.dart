// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxDashCard — Titled dashboard card container.
///
/// Composition: Mono-label header + child content inside a bordered card.
/// Styling: bg-1, border, r12, card padding. Header is mono 10px/600.
///
/// Used extensively in the Home Dashboard for Financial Pulse, Cash Flow,
/// Budget Items, etc.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A dashboard card with a monospaced section title.
class NxDashCard extends StatelessWidget {
  const NxDashCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  /// Uppercase section title displayed in mono font.
  final String title;

  /// Card body content.
  final Widget child;

  /// Optional trailing widget next to the title (e.g. an action button).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Container(
      padding: const EdgeInsets.all(kCardPadding),
      decoration: BoxDecoration(
        color: c.bg1,
        borderRadius: kRadiusMd,
        border: Border.all(color: c.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: nxMonoSm().copyWith(
                    color: c.textLow,
                    fontWeight: kWeightSemiBold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: kSpaceLg),
          child,
        ],
      ),
    );
  }
}

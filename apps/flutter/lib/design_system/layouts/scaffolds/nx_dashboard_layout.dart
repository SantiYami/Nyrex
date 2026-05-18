// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxDashboardLayout — Responsive grid layout for dashboard pages.
///
/// Provides a consistent responsive column layout that stacks
/// on narrow screens and expands to a multi-column grid on desktop.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A responsive layout that arranges columns side-by-side on wide
/// screens and stacks them vertically on narrow screens.
class NxDashboardLayout extends StatelessWidget {
  const NxDashboardLayout({
    super.key,
    required this.columns,
    this.breakpoint = 900,
    this.spacing = kSpaceLg,
  });

  /// The columns to arrange.
  final List<Widget> columns;

  /// The width at which the layout switches from stacked to side-by-side.
  final double breakpoint;

  /// Spacing between columns.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return Column(
            children: [
              for (int i = 0; i < columns.length; i++) ...[
                columns[i],
                if (i < columns.length - 1) SizedBox(height: spacing),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < columns.length; i++) ...[
              Expanded(child: columns[i]),
              if (i < columns.length - 1) SizedBox(width: spacing),
            ],
          ],
        );
      },
    );
  }
}

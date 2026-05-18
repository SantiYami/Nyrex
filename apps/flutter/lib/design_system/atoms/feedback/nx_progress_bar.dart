// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxProgressBar — semantic progress bar for Nyrex.
///
/// Track: bg-1. Height: 4–6px. Radius: full.
/// Fill color by semantic state:
///   success (green) → warning (yellow) → error (red).
///
/// ```dart
/// NxProgressBar(
///   value: 0.75,
///   state: NxProgressState.warning,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// Semantic state for progress bar fill color.
enum NxProgressState {
  /// Healthy / within budget — success green.
  success,

  /// Approaching threshold — warning yellow.
  warning,

  /// Exceeded / critical — error red.
  error,
}

/// A themed progress bar with semantic coloring.
class NxProgressBar extends StatelessWidget {
  const NxProgressBar({
    super.key,
    required this.value,
    this.state = NxProgressState.success,
    this.height = 4,
    this.color,
  });

  /// Progress value (0.0 – 1.0). Clamped internally.
  final double value;

  /// Semantic state for fill color (used when [color] is null).
  final NxProgressState state;

  /// Bar height in pixels (default: 4px).
  final double height;

  /// Optional explicit fill color. Overrides [state]-based color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final fillColor =
        color ??
        switch (state) {
          NxProgressState.success => kColorSuccess,
          NxProgressState.warning => kColorWarning,
          NxProgressState.error => kColorError,
        };

    final clampedValue = value.clamp(0.0, 1.0);

    return Container(
      height: height,
      decoration: BoxDecoration(color: c.bg1, borderRadius: kRadiusFull),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: kDurationDefault,
                curve: kCurveEmphasized,
                width: constraints.maxWidth * clampedValue,
                height: height,
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: kRadiusFull,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxMoneyDisplay — financial amount renderer for Nyrex.
///
/// Uses JetBrains Mono with tabular figures.
/// Color changes based on semantic state:
///   normal (text-1), positive (success), caution (warning), deficit (error).
///
/// ```dart
/// NxMoneyDisplay(
///   amount: 1234.56,
///   currency: '\$',
///   state: NxMoneyState.positive,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// Semantic state for money display coloring.
enum NxMoneyState {
  /// Default — text-1.
  normal,

  /// Healthy / profit — success green.
  positive,

  /// Approaching limit — warning yellow.
  caution,

  /// Exceeded / loss — error red.
  deficit,
}

/// Renders a monetary amount in JetBrains Mono with tabular figures.
class NxMoneyDisplay extends StatelessWidget {
  const NxMoneyDisplay({
    super.key,
    required this.amount,
    this.currency = '\$',
    this.state = NxMoneyState.normal,
    this.fontSize = 12,
  });

  /// The numeric amount to display.
  final double amount;

  /// Currency symbol prefix.
  final String currency;

  /// Semantic state for coloring.
  final NxMoneyState state;

  /// Font size override (default: 12px mono).
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final color = switch (state) {
      NxMoneyState.normal => c.textHigh,
      NxMoneyState.positive => kColorSuccess,
      NxMoneyState.caution => kColorWarning,
      NxMoneyState.deficit => kColorError,
    };

    final formatted = amount < 0
        ? '-$currency${amount.abs().toStringAsFixed(2)}'
        : '$currency${amount.toStringAsFixed(2)}';

    return Text(
      formatted,
      style: nxMono().copyWith(fontSize: fontSize, color: color),
    );
  }
}

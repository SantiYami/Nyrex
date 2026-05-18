// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/colors.dart';

/// Custom theme extension for semantic colors that don't fit perfectly
/// into Material's ColorScheme slots.
class NxSemanticColors extends ThemeExtension<NxSemanticColors> {
  const NxSemanticColors({required this.textLow});

  final Color textLow;

  @override
  NxSemanticColors copyWith({Color? textLow}) {
    return NxSemanticColors(textLow: textLow ?? this.textLow);
  }

  @override
  NxSemanticColors lerp(ThemeExtension<NxSemanticColors>? other, double t) {
    if (other is! NxSemanticColors) return this;
    return NxSemanticColors(
      textLow: Color.lerp(textLow, other.textLow, t) ?? textLow,
    );
  }
}

/// NxColors — theme-aware surface/text color resolver.
///
/// Usage: `final c = NxColors.of(context);`
/// Then:  `c.bg0`, `c.bg1`, `c.bg2`, `c.border`, `c.divider`,
///        `c.textHigh`, `c.textMedium`, `c.textLow`.
class NxColors {
  NxColors._(this._theme);

  factory NxColors.of(BuildContext context) => NxColors._(Theme.of(context));

  final ThemeData _theme;
  ColorScheme get _cs => _theme.colorScheme;
  NxSemanticColors get _semantic =>
      _theme.extension<NxSemanticColors>() ??
      const NxSemanticColors(textLow: kColorTextLow);

  // ── Surfaces ──────────────────────────────────────────
  Color get bg0 => _theme.scaffoldBackgroundColor; // canvas
  Color get bg1 => _cs.surface; // panels
  Color get bg2 => _theme.cardColor; // cards
  Color get border => _cs.outline; // borders
  Color get divider => _cs.outlineVariant; // dividers

  // ── Text ──────────────────────────────────────────────
  Color get textHigh => _cs.onSurface;
  Color get textMedium => _cs.onSurfaceVariant;
  Color get textLow => _semantic.textLow;

  // ── Brand / Semantic ──────────────────────────────────
  Color get primary => _cs.primary;
  Color get confirmation => _cs.secondary;
  Color get error => _cs.error;
  Color get warning => kColorWarning;
  Color get success => kColorSuccess;
  Color get info => kColorInfo;
}

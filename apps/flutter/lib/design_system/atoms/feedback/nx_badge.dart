// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxBadge — pill-shaped status indicator.
///
/// Caption size (11px/600). Bg: bg-2. Radius: full.
/// 7 variants: default, selected, saved, within, warning, over, info.
///
/// ```dart
/// NxBadge(label: 'Active', variant: NxBadgeVariant.selected)
/// ```
library;

import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// Variant of [NxBadge].
enum NxBadgeVariant {
  /// Default — no border, text-2.
  normal,

  /// Active selection — primary border + text.
  selected,

  /// Saved / confirmed — teal border + text.
  saved,

  /// Within limits — success border + text.
  within,

  /// Approaching threshold — warning border + text.
  warning,

  /// Exceeded / critical — error border + text.
  over,

  /// Informational — info border + text.
  info,
}

/// A pill-shaped status badge.
class NxBadge extends StatelessWidget {
  const NxBadge({
    super.key,
    required this.label,
    this.variant = NxBadgeVariant.normal,
  });

  /// Badge text.
  final String label;

  /// Visual variant.
  final NxBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final (borderColor, textColor) = _resolveColors(c);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceSm,
        vertical: kSpaceXs,
      ),
      decoration: BoxDecoration(
        color: c.bg2,
        borderRadius: kRadiusFull,
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
      ),
      child: Text(
        label,
        style: nxCaption().copyWith(
          color: textColor,
          fontWeight: kWeightSemiBold,
        ),
      ),
    );
  }

  (Color? border, Color text) _resolveColors(NxColors c) {
    return switch (variant) {
      NxBadgeVariant.normal => (null, c.textMedium),
      NxBadgeVariant.selected => (kColorPrimary, kColorPrimary),
      NxBadgeVariant.saved => (kColorConfirmation, kColorConfirmation),
      NxBadgeVariant.within => (kColorSuccess, kColorSuccess),
      NxBadgeVariant.warning => (kColorWarning, kColorWarning),
      NxBadgeVariant.over => (kColorError, kColorError),
      NxBadgeVariant.info => (kColorInfo, kColorInfo),
    };
  }
}

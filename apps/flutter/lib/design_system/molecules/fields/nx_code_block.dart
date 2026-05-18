// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxCodeBlock — Styled code block with monospace font.
///
/// Composition: Container with mono text, bg-2 background, border.
/// Used in Notes screen for inline code snippets.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A styled code block with monospace font and dark background.
class NxCodeBlock extends StatelessWidget {
  const NxCodeBlock({super.key, required this.code, this.language});

  /// The code content to display.
  final String code;

  /// Optional language label (for future use).
  final String? language;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kSpaceLg),
      decoration: BoxDecoration(
        color: c.bg2,
        borderRadius: kRadiusMd,
        border: Border.all(color: c.border, width: 1),
      ),
      child: Text(
        code,
        style: nxMono().copyWith(color: c.textMedium, height: 1.6),
      ),
    );
  }
}

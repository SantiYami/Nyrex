// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxKbd — platform-adaptive keyboard shortcut pill.
///
/// Small pill: bg-2, border, mono caption (11px).
/// Platform-adaptive: ⌘ on macOS, Ctrl on Windows/Linux.
///
/// ```dart
/// NxKbd(label: '⌘K') // auto-adapts to Ctrl+K on Windows.
/// NxKbd.raw('ESC')     // No adaptation.
/// ```
library;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// A keyboard shortcut hint pill.
class NxKbd extends StatelessWidget {
  /// Creates a platform-adaptive kbd pill.
  ///
  /// If [label] starts with `⌘`, it will be replaced with `Ctrl+`
  /// on non-macOS platforms.
  const NxKbd({super.key, required this.label, this.adaptPlatform = true});

  /// Creates a raw kbd pill without platform adaptation.
  const NxKbd.raw(this.label, {super.key}) : adaptPlatform = false;

  /// The shortcut text. Example: `⌘K`, `N`, `↵`, `ESC`.
  final String label;

  /// Whether to auto-replace `⌘` with `Ctrl+` on non-macOS.
  final bool adaptPlatform;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final displayLabel = _adaptLabel();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpaceSm, vertical: 2),
      decoration: BoxDecoration(
        color: c.bg2,
        borderRadius: kRadiusSm,
        border: Border.all(color: c.border, width: 1),
      ),
      child: Text(
        displayLabel,
        style: nxMono().copyWith(fontSize: 11, color: c.textMedium),
      ),
    );
  }

  String _adaptLabel() {
    if (!adaptPlatform) return label;

    final isMac = defaultTargetPlatform == TargetPlatform.macOS;
    if (isMac) return label;

    // Replace ⌘ with Ctrl+ for Windows/Linux.
    return label.replaceAll('⌘', 'Ctrl+');
  }
}

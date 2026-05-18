// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxIconButton — ghost icon tap target for Nyrex.
///
/// Radius: r8. Hover: bg-2. Icon: text-2, hover: text-1.
///
/// ```dart
/// NxIconButton(
///   icon: Icons.settings,
///   onPressed: () => openSettings(),
///   tooltip: 'Settings',
/// )
/// ```
library;

import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// A ghost icon button with hover highlight.
class NxIconButton extends StatefulWidget {
  const NxIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 20.0,
  });

  /// The icon to display.
  final IconData icon;

  /// Tap callback — null means disabled.
  final VoidCallback? onPressed;

  /// Optional tooltip text.
  final String? tooltip;

  /// Icon size (default: 20px).
  final double size;

  @override
  State<NxIconButton> createState() => _NxIconButtonState();
}

class _NxIconButtonState extends State<NxIconButton> {
  bool _hovered = false;

  static final bool _supportsHover =
      kIsWeb ||
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final child = MouseRegion(
      cursor: widget.onPressed == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: _supportsHover ? (_) => setState(() => _hovered = true) : null,
      onExit: _supportsHover ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: kDurationDefault,
          curve: kCurveEmphasized,
          width: widget.size + 16,
          height: widget.size + 16,
          decoration: BoxDecoration(
            color: _hovered ? c.bg2 : Colors.transparent,
            borderRadius: kRadiusDefault,
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: widget.size,
              color: _hovered ? c.textHigh : c.textMedium,
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: child);
    }
    return child;
  }
}

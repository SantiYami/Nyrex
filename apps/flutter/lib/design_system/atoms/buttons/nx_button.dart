// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxButton — the primary action widget for Nyrex.
///
/// Variants: `primary`, `secondary`, `ghost`, `danger`.
/// Sizes: `sm` (32px) or `md` (36px, default).
///
/// ```dart
/// NxButton(
///   label: 'Save',
///   variant: NxButtonVariant.primary,
///   onPressed: () => save(),
/// )
/// ```
library;

import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// Visual variant of [NxButton].
enum NxButtonVariant { primary, secondary, ghost, danger }

/// Size of [NxButton].
enum NxButtonSize {
  /// 32px compact.
  sm,

  /// 36px standard (default).
  md,
}

/// A themed action button following the Nyrex design spec.
///
/// Features:
///  - Platform-aware hover (only on web/desktop).
///  - Optional leading [icon].
///  - Disabled state with 40% opacity + no pointer.
///  - 200ms easeOut transitions.
class NxButton extends StatefulWidget {
  const NxButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = NxButtonVariant.primary,
    this.size = NxButtonSize.md,
    this.icon,
  });

  /// Button text label.
  final String label;

  /// Callback — null means disabled.
  final VoidCallback? onPressed;

  /// Visual variant.
  final NxButtonVariant variant;

  /// Button size.
  final NxButtonSize size;

  /// Optional leading icon (16px).
  final IconData? icon;

  bool get _isDisabled => onPressed == null;

  @override
  State<NxButton> createState() => _NxButtonState();
}

class _NxButtonState extends State<NxButton> {
  bool _hovered = false;

  // Platform check: enable hover effects only on web or desktop.
  static final bool _supportsHover =
      kIsWeb ||
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final height = widget.size == NxButtonSize.sm ? 32.0 : 36.0;

    return MouseRegion(
      cursor: widget._isDisabled
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: _supportsHover ? (_) => setState(() => _hovered = true) : null,
      onExit: _supportsHover ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        onTap: widget._isDisabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: kDurationDefault,
          curve: kCurveEmphasized,
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: widget.size == NxButtonSize.sm ? kSpaceMd : kSpaceLg,
          ),
          decoration: BoxDecoration(
            color: _resolveBackground(c),
            borderRadius: kRadiusDefault,
            border: _resolveBorder(c),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: _resolveForeground(c)),
                const SizedBox(width: kSpaceSm),
              ],
              Text(
                widget.label,
                style: nxH3().copyWith(color: _resolveForeground(c)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _resolveBackground(NxColors c) {
    if (widget._isDisabled) return Colors.transparent;

    switch (widget.variant) {
      case NxButtonVariant.primary:
        return _hovered ? kColorPrimaryHover : kColorPrimary;
      case NxButtonVariant.secondary:
        return _hovered ? c.bg2.withAlpha(200) : c.bg2;
      case NxButtonVariant.ghost:
        return _hovered ? c.bg2 : Colors.transparent;
      case NxButtonVariant.danger:
        return _hovered ? kColorError.withAlpha(200) : kColorError;
    }
  }

  Color _resolveForeground(NxColors c) {
    if (widget._isDisabled) return c.textHigh.withAlpha(102); // 40%

    switch (widget.variant) {
      case NxButtonVariant.primary:
      case NxButtonVariant.danger:
        return Colors.white;
      case NxButtonVariant.secondary:
        return c.textHigh;
      case NxButtonVariant.ghost:
        return c.textMedium;
    }
  }

  Border? _resolveBorder(NxColors c) {
    if (widget._isDisabled) {
      return Border.all(color: c.border, width: 1);
    }

    switch (widget.variant) {
      case NxButtonVariant.secondary:
        return Border.all(color: c.border, width: 1);
      case NxButtonVariant.primary:
      case NxButtonVariant.ghost:
      case NxButtonVariant.danger:
        return null;
    }
  }
}

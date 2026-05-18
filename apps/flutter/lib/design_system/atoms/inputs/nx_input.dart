// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxInput — styled text field for Nyrex.
///
/// Height: 36px. Fill: bg-0. Radius: r8.
/// States: default, focus (primary glow ring), error, success.
///
/// ```dart
/// NxInput(
///   hint: 'Search…',
///   leadingIcon: Icons.search,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// Validation state of [NxInput].
enum NxInputState { normal, error, success }

/// A themed text input matching the Nyrex design spec.
///
/// Wraps a [TextField] with standardized styling and optional helper text.
class NxInput extends StatelessWidget {
  const NxInput({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.helperText,
    this.leadingIcon,
    this.obscureText = false,
    this.inputState = NxInputState.normal,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.focusNode,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? helperText;
  final IconData? leadingIcon;
  final bool obscureText;
  final NxInputState inputState;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    final borderColor = switch (inputState) {
      NxInputState.error => kColorError,
      NxInputState.success => kColorSuccess,
      NxInputState.normal => c.border,
    };

    final helperColor = switch (inputState) {
      NxInputState.error => kColorError,
      NxInputState.success => kColorSuccess,
      NxInputState.normal => c.textMedium,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: nxH3().copyWith(color: c.textHigh)),
          const SizedBox(height: kSpaceXs),
        ],
        SizedBox(
          height: 36,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: autofocus,
            obscureText: obscureText,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            style: nxBody().copyWith(color: c.textHigh),
            cursorColor: kColorPrimary,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: nxBody().copyWith(color: c.textLow),
              filled: true,
              fillColor: c.bg0,
              contentPadding: const EdgeInsets.symmetric(horizontal: kSpaceMd),
              prefixIcon: leadingIcon != null
                  ? Icon(leadingIcon, size: 18, color: c.textMedium)
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              border: OutlineInputBorder(
                borderRadius: kRadiusDefault,
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: kRadiusDefault,
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: kRadiusDefault,
                borderSide: BorderSide(color: kColorPrimary, width: 1),
              ),
              // Focus glow ring is applied via the theme's
              // input decoration or via a custom overlay in molecules.
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: kSpaceXs),
          Text(helperText!, style: nxCaption().copyWith(color: helperColor)),
        ],
      ],
    );
  }
}

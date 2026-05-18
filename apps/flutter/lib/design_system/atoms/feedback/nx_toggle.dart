// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxToggle — on/off switch for Nyrex.
///
/// Size: 36×20px. Thumb: white. Track off: border. Track on: primary.
/// Transition: 200ms.
///
/// ```dart
/// NxToggle(
///   value: isEnabled,
///   onChanged: (v) => setState(() => isEnabled = v),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import 'package:nyrex/design_system/tokens/tokens.dart';

/// A custom toggle switch matching the Nyrex design spec.
class NxToggle extends StatelessWidget {
  const NxToggle({super.key, required this.value, required this.onChanged});

  /// Current toggle state.
  final bool value;

  /// Called when the user taps the toggle.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: kDurationDefault,
        curve: kCurveEmphasized,
        width: 36,
        height: 20,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? kColorPrimary : c.border,
          borderRadius: BorderRadius.circular(kRadiusDefaultValue),
        ),
        child: AnimatedAlign(
          duration: kDurationDefault,
          curve: kCurveEmphasized,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

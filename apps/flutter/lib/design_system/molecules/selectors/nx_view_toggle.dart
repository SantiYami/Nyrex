// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxViewToggle — Segmented view switcher.
///
/// Displays a row of text options (e.g. List / Board / Timeline)
/// with an active highlight. Used in Tasks screen.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A segmented view toggle for switching between display modes.
class NxViewToggle extends StatelessWidget {
  const NxViewToggle({
    super.key,
    required this.options,
    required this.activeIndex,
    this.onChanged,
  });

  /// The list of option labels.
  final List<String> options;

  /// The currently active option index.
  final int activeIndex;

  /// Called when a different option is selected.
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(options.length, (i) {
        final isActive = i == activeIndex;
        return GestureDetector(
          onTap: () => onChanged?.call(i),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: const EdgeInsets.only(right: kSpaceXs),
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceMd,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive ? c.bg2 : Colors.transparent,
                borderRadius: kRadiusDefault,
              ),
              child: Text(
                options[i],
                style: nxCaption().copyWith(
                  color: isActive ? c.textHigh : c.textLow,
                  fontWeight: isActive ? kWeightSemiBold : kWeightRegular,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

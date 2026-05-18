// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxSectionHeader — Breadcrumb-style module header.
///
/// Displays a breadcrumb path like `TASKS / Today` in mono font
/// with optional trailing actions.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A breadcrumb-style section header used at the top of module screens.
class NxSectionHeader extends StatelessWidget {
  const NxSectionHeader({
    super.key,
    required this.breadcrumb,
    this.actions = const [],
  });

  /// Breadcrumb text, e.g. `'TASKS  /  Today'`.
  final String breadcrumb;

  /// Optional trailing action widgets (buttons, toggles, etc).
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Row(
      children: [
        Text(
          breadcrumb,
          style: nxMonoSm().copyWith(
            color: c.textLow,
            fontWeight: kWeightMedium,
            letterSpacing: 0.5,
          ),
        ),
        const Spacer(),
        ...actions,
      ],
    );
  }
}

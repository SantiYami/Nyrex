// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxEmptyState — Standard empty state placeholder.
///
/// Composition: Centered icon, title, description, and optional CTA button.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';

class NxEmptyState extends StatelessWidget {
  const NxEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpace3xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: c.textLow, // Text-3 equivalent
            ),
            const SizedBox(height: kSpaceLg),
            Text(
              title,
              style: nxH2().copyWith(color: c.textHigh),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSpaceSm),
            Text(
              description,
              style: nxBody().copyWith(color: c.textMedium),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: kSpaceXl),
              NxButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: NxButtonVariant.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

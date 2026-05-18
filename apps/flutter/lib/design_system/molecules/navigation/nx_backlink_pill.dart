// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxBacklinkPill — Linked note reference pill.
///
/// Composition: Link icon + label text inside a pill with primary-soft bg.
/// Used in Notes screen for backlink references.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A pill-shaped backlink reference widget.
class NxBacklinkPill extends StatelessWidget {
  const NxBacklinkPill({super.key, required this.title, this.onTap});

  /// The linked note title.
  final String title;

  /// Called when the pill is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpaceMd,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: kColorPrimarySoft,
            borderRadius: kRadiusFull,
            border: Border.all(color: kColorPrimary.withAlpha(40), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.link, size: 12, color: kColorAccentText),
              const SizedBox(width: kSpaceXs),
              Text(
                title,
                style: nxSecondary().copyWith(color: kColorAccentText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

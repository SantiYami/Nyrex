// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxSidebar — 200px module navigation panel.
///
/// Accepts a [child] widget for modular sidebar content that varies
/// per active route (Home, Notes, Vault, Tasks, etc.).
///
/// The sidebar itself provides the container styling (bg-1, right border,
/// 200px width). Module-specific sidebars compose their own content.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

class NxSidebar extends StatelessWidget {
  const NxSidebar({super.key, required this.child, this.width = kSidebarWidth});

  /// Module-specific sidebar content widget.
  final Widget child;

  /// Width of the sidebar. Defaults to [kSidebarWidth] (200px).
  final double width;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: c.bg1,
        border: Border(right: BorderSide(color: c.divider, width: 1)),
      ),
      child: child,
    );
  }
}

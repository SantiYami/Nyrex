// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxAppShell — The immutable three-layer navigation shell.
///
/// Composition: NxIconRail + NxSidebar + Content.
/// Responsive layout built-in (mobile vs desktop).
///
/// The sidebar accepts a [Widget] for modular content that varies
/// per active route.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

import 'nx_icon_rail.dart';
import 'nx_sidebar.dart';

class NxAppShell extends StatelessWidget {
  const NxAppShell({
    super.key,
    required this.child,
    required this.railItems,
    this.bottomRailItem,
    this.sidebarContent,
    this.onCommandPaletteRequested,
    this.isFocusMode = false,
  });

  final Widget child;
  final List<NxRailItem> railItems;
  final NxRailItem? bottomRailItem;

  /// Module-specific sidebar content widget. When null, no sidebar is shown.
  final Widget? sidebarContent;
  final VoidCallback? onCommandPaletteRequested;
  final bool isFocusMode;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Scaffold(
      backgroundColor: c.bg0,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          if (isMobile) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(kSpaceLg),
                    child: child,
                  ),
                ),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: c.bg1,
                    border: Border(top: BorderSide(color: c.border)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: railItems.take(5).map((e) {
                      return IconButton(
                        icon: Icon(
                          e.icon,
                          color: e.isActive ? kColorPrimary : c.textLow,
                        ),
                        onPressed: e.onTap,
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxIconRail(
                items: railItems,
                bottomItem: bottomRailItem,
                isFocusMode: isFocusMode,
              ),
              if (sidebarContent != null && !isFocusMode)
                NxSidebar(child: sidebarContent!),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(kSpace2xl),
                  child: child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

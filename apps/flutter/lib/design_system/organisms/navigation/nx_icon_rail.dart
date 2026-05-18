// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxIconRail — 52px fixed global navigation rail.
///
/// Features:
/// - 52px width, kColorDarkBg0 background, kColorDarkDivider right border.
/// - Brand mark: 28×28, rounded-7, acc bg, white 'n', JetBrains Mono 700.
/// - Active state: bg-2, acc icon color, 3×20px violet bar on left edge.
/// - Hover state: bg-2, text-high icon color.
/// - Divider: 24×1px below brand mark.
/// - v1.0 label at bottom in JetBrains Mono 500 9.5px.
library;

import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

class NxRailItem {
  const NxRailItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
}

class NxIconRail extends StatelessWidget {
  const NxIconRail({
    super.key,
    required this.items,
    this.bottomItem,
    this.isFocusMode = false,
  });

  final List<NxRailItem> items;
  final NxRailItem? bottomItem;
  final bool isFocusMode;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return AnimatedOpacity(
      duration: kDurationDefault,
      opacity: isFocusMode ? 0.2 : 1.0,
      child: Container(
        width: kRailWidth,
        decoration: BoxDecoration(
          color: c.bg0,
          border: Border(right: BorderSide(color: c.divider, width: 1)),
        ),
        child: Column(
          children: [
            const SizedBox(height: kSpaceLg),
            // Brand mark — 28×28, rounded-7, acc bg, white 'n'
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: kRadiusDefault,
              ),
              child: Center(
                child: Text(
                  'n',
                  style: nxSecondary().copyWith(
                    color: Colors.white,
                    fontWeight: kWeightBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: kSpaceMd),
            // Divider — 24×1px
            Container(width: 24, height: 1, color: c.divider),
            const SizedBox(height: kSpaceMd),
            ...items.map((item) => _NxRailItemWidget(item: item)),
            const Spacer(),
            // Version label — JetBrains Mono 500 9.5px
            Text(
              'v1.0',
              style: nxMonoSm().copyWith(
                color: c.textLow,
                fontWeight: kWeightMedium,
              ),
            ),
            const SizedBox(height: kSpaceMd),
            if (bottomItem != null) _NxRailItemWidget(item: bottomItem!),
            const SizedBox(height: kSpaceLg),
          ],
        ),
      ),
    );
  }
}

class _NxRailItemWidget extends StatefulWidget {
  const _NxRailItemWidget({required this.item});

  final NxRailItem item;

  @override
  State<_NxRailItemWidget> createState() => _NxRailItemWidgetState();
}

class _NxRailItemWidgetState extends State<_NxRailItemWidget> {
  bool _hovered = false;

  static final bool _supportsHover =
      kIsWeb ||
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final c = NxColors.of(context);

    Color bgColor = Colors.transparent;
    Color iconColor = c.textLow;

    if (item.isActive) {
      bgColor = c.bg2;
      iconColor = kColorPrimary;
    } else if (_hovered) {
      bgColor = c.bg2;
      iconColor = c.textHigh;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _supportsHover ? (_) => setState(() => _hovered = true) : null,
      onExit: _supportsHover ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        onTap: item.onTap,
        child: Tooltip(
          message: item.label,
          preferBelow: false,
          child: Container(
            width: kRowHeight, // 36×36
            height: kRowHeight,
            margin: const EdgeInsets.only(bottom: kSpaceSm),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background fill
                AnimatedContainer(
                  duration: kDurationFast,
                  width: kRowHeight,
                  height: kRowHeight,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: kRadiusDefault,
                  ),
                ),
                // Active indicator — 3×20px bar, left edge, rounded right
                if (item.isActive)
                  Positioned(
                    left: -2,
                    child: Container(
                      width: 3,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                Icon(item.icon, size: 20, color: iconColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

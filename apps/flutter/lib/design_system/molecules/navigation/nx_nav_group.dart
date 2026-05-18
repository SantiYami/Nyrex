// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxNavGroup — Collapsible navigation section header with items.
///
/// Composition: Uppercase section header + list of nav items.
/// Active item styling: acc-soft bg, left indicator bar, acc-text color.
///
/// JSX alignment:
/// - Section header: 600 10.5px/1, 0.08em letter-spacing, uppercase, text-3
/// - Nav rows: padding 7px 10px, border-radius 8, text-2 color
/// - Active row: acc-active bg, acc-text color, 3×14px left indicator bar
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

class NxNavItem {
  const NxNavItem({
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.trailing,
    this.leading,
  });

  final String label;
  final VoidCallback onTap;
  final bool isActive;

  /// Optional trailing widget (e.g., count badge).
  final Widget? trailing;

  /// Optional leading widget (e.g., project color dot).
  final Widget? leading;
}

class NxNavGroup extends StatefulWidget {
  const NxNavGroup({
    super.key,
    required this.title,
    required this.items,
    this.initiallyExpanded = true,
  });

  final String title;
  final List<NxNavItem> items;
  final bool initiallyExpanded;

  @override
  State<NxNavGroup> createState() => _NxNavGroupState();
}

class _NxNavGroupState extends State<NxNavGroup> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header — JSX: 600 10.5px/1, 0.08em, uppercase, text-3
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: kRadiusSm,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSpaceSm,
              vertical: kSpaceSm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title.toUpperCase(),
                    style: nxMonoSm().copyWith(
                      color: c.textLow,
                      fontWeight: kWeightSemiBold,
                      letterSpacing: 0.84,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 14,
                  color: c.textLow,
                ),
              ],
            ),
          ),
        ),

        // Items
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(top: kSpaceXs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return _NxNavItemWidget(item: item);
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _NxNavItemWidget extends StatelessWidget {
  const _NxNavItemWidget({required this.item});

  final NxNavItem item;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return InkWell(
      onTap: item.onTap,
      borderRadius: kRadiusDefault,
      child: Container(
        height: kRowHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: item.isActive ? kColorPrimarySoft : Colors.transparent,
          borderRadius: kRadiusDefault,
        ),
        child: Row(
          children: [
            // Active indicator — 3×14px bar
            if (item.isActive)
              Container(
                width: 3,
                height: 14,
                margin: const EdgeInsets.only(right: kSpaceSm),
                decoration: const BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            // Optional leading widget (e.g., project dot)
            if (item.leading != null) ...[
              item.leading!,
              const SizedBox(width: kSpaceSm),
            ],
            Expanded(
              child: Text(
                item.label,
                style: nxSecondary().copyWith(
                  color: item.isActive ? kColorAccentText : c.textMedium,
                  fontWeight: item.isActive ? kWeightMedium : kWeightRegular,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (item.trailing != null) item.trailing!,
          ],
        ),
      ),
    );
  }
}

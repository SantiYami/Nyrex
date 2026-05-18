// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxItemCard — Complex list item or grid card.
///
/// Composition: Icon + labels + NxProgressBar + NxToggle + action.
/// Styling: bg-2, border, r12. Hover → primary border.
library;

import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';

class NxItemCard extends StatefulWidget {
  const NxItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.progressValue,
    this.progressState = NxProgressState.success,
    this.isToggled,
    this.onToggleChanged,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final double? progressValue;
  final NxProgressState progressState;
  final bool? isToggled;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;

  @override
  State<NxItemCard> createState() => _NxItemCardState();
}

class _NxItemCardState extends State<NxItemCard> {
  bool _hovered = false;

  static final bool _supportsHover =
      kIsWeb ||
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: _supportsHover ? (_) => setState(() => _hovered = true) : null,
      onExit: _supportsHover ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: kDurationDefault,
          curve: kCurveEmphasized,
          padding: const EdgeInsets.all(kSpaceLg),
          decoration: BoxDecoration(
            color: c.bg2,
            borderRadius: kRadiusMd,
            border: Border.all(
              color: _hovered ? kColorPrimary : c.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.bg1,
                  borderRadius: kRadiusDefault,
                ),
                child: Center(
                  child: Icon(widget.icon, size: 20, color: c.textMedium),
                ),
              ),
              const SizedBox(width: kSpaceLg),

              // Labels + Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: nxH3().copyWith(color: c.textHigh),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: nxBody().copyWith(color: c.textMedium),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.progressValue != null) ...[
                      const SizedBox(height: kSpaceSm),
                      NxProgressBar(
                        value: widget.progressValue!,
                        state: widget.progressState,
                      ),
                    ],
                  ],
                ),
              ),

              // Toggle
              if (widget.isToggled != null &&
                  widget.onToggleChanged != null) ...[
                const SizedBox(width: kSpaceLg),
                NxToggle(
                  value: widget.isToggled!,
                  onChanged: widget.onToggleChanged!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

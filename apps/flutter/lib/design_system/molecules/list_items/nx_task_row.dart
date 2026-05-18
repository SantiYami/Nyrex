// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxTaskRow — Single task list item.
///
/// Composition: Checkbox + priority dot + title + project label + tags + due.
/// Styled with bg-1, border, rounded corners.
///
/// Used in Tasks screen and Home dashboard (Focus Tasks).
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// A single task row with checkbox, priority, labels, and due date.
class NxTaskRow extends StatelessWidget {
  const NxTaskRow({
    super.key,
    required this.title,
    required this.priorityColor,
    this.project,
    this.projectColor,
    this.tags = const [],
    this.dueLabel,
    this.isOverdue = false,
    this.isCompleted = false,
    this.onTap,
    this.onCheckChanged,
  });

  /// Task title text.
  final String title;

  /// Color of the priority indicator dot.
  final Color priorityColor;

  /// Project name label (optional).
  final String? project;

  /// Project label color (optional).
  final Color? projectColor;

  /// List of tag strings (e.g. `['#bug', '#backend']`).
  final List<String> tags;

  /// Due date label (e.g. `'Today'`, `'Yesterday'`).
  final String? dueLabel;

  /// Whether this task is overdue (applies error styling to due label).
  final bool isOverdue;

  /// Whether this task is completed (applies strikethrough + dimmed style).
  final bool isCompleted;

  /// Called when the row is tapped.
  final VoidCallback? onTap;

  /// Called when the checkbox state changes.
  final ValueChanged<bool>? onCheckChanged;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: kSpaceXs),
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceMd,
          vertical: kSpaceSm,
        ),
        decoration: BoxDecoration(
          color: c.bg1,
          borderRadius: kRadiusDefault,
          border: Border.all(color: c.border, width: 1),
        ),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () => onCheckChanged?.call(!isCompleted),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? kColorConfirmation.withAlpha(30)
                      : Colors.transparent,
                  borderRadius: kRadiusSm,
                  border: Border.all(
                    color: isCompleted ? kColorConfirmation : c.border,
                    width: 1.5,
                  ),
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        size: 12,
                        color: kColorConfirmation,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: kSpaceMd),
            // Priority dot
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: priorityColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: kSpaceSm),
            // Title
            Expanded(
              child: Text(
                title,
                style: nxBody().copyWith(
                  color: isCompleted ? c.textLow : c.textHigh,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Project label
            if (project != null && projectColor != null)
              Container(
                margin: const EdgeInsets.only(left: kSpaceSm),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: projectColor!.withAlpha(25),
                  borderRadius: kRadiusSm,
                ),
                child: Text(
                  project!,
                  style: nxCaption().copyWith(color: projectColor),
                ),
              ),
            // Tags
            ...tags
                .take(2)
                .map(
                  (tag) => Padding(
                    padding: const EdgeInsets.only(left: kSpaceXs),
                    child: Text(
                      tag,
                      style: nxCaption().copyWith(color: c.textLow),
                    ),
                  ),
                ),
            // Due date
            if (dueLabel != null) ...[
              const SizedBox(width: kSpaceSm),
              Text(
                dueLabel!,
                style: nxMonoSm().copyWith(
                  color: isOverdue ? kColorError : c.textLow,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

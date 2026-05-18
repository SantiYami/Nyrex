// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxTaskGroup — A group of tasks with a header label.
///
/// Composition: Group header (mono label + count) + list of [NxTaskRow].
/// Used in Tasks screen to display grouped task lists.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';

/// Configuration for a single task within a group.
class NxTaskConfig {
  const NxTaskConfig({
    required this.title,
    required this.priorityColor,
    this.project,
    this.projectColor,
    this.tags = const [],
    this.dueLabel,
    this.isCompleted = false,
    this.onTap,
    this.onCheckChanged,
  });

  final String title;
  final Color priorityColor;
  final String? project;
  final Color? projectColor;
  final List<String> tags;
  final String? dueLabel;
  final bool isCompleted;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckChanged;
}

/// A grouped list of tasks with a header.
class NxTaskGroup extends StatelessWidget {
  const NxTaskGroup({
    super.key,
    required this.groupName,
    required this.tasks,
    this.isOverdue = false,
  });

  /// Group header label (e.g. `'OVERDUE'`, `'TODAY'`).
  final String groupName;

  /// List of task configurations.
  final List<NxTaskConfig> tasks;

  /// Whether this group represents overdue tasks (error styling).
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group header
          Padding(
            padding: const EdgeInsets.only(bottom: kSpaceSm),
            child: Row(
              children: [
                Text(
                  groupName,
                  style: nxMonoSm().copyWith(
                    color: isOverdue ? kColorError : c.textLow,
                    fontWeight: kWeightSemiBold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: kSpaceSm),
                Text(
                  '${tasks.length}',
                  style: nxMonoSm().copyWith(color: c.textLow),
                ),
              ],
            ),
          ),
          // Tasks
          ...tasks.map(
            (t) => NxTaskRow(
              title: t.title,
              priorityColor: t.priorityColor,
              project: t.project,
              projectColor: t.projectColor,
              tags: t.tags,
              dueLabel: t.dueLabel,
              isOverdue: isOverdue,
              isCompleted: t.isCompleted,
              onTap: t.onTap,
              onCheckChanged: t.onCheckChanged,
            ),
          ),
        ],
      ),
    );
  }
}

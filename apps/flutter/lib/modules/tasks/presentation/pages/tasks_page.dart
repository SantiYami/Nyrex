// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// TasksPage — Task list with groups, quick capture, and view toggles.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/core/data/mock_data.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/design_system/organisms/organisms.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Group tasks by their group field
    final groups = <String, List<MockTask>>{};
    for (final t in kMockTasks) {
      groups.putIfAbsent(t.group, () => []).add(t);
    }

    // Order groups
    const order = [
      'OVERDUE',
      'TODAY',
      'TOMORROW',
      'UPCOMING',
      'NO DATE',
      'COMPLETED',
    ];
    final orderedGroups = order.where((g) => groups.containsKey(g)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        NxSectionHeader(
          breadcrumb: 'TASKS  /  Today',
          actions: [
            const NxViewToggle(
              options: ['List', 'Board', 'Timeline'],
              activeIndex: 0,
            ),
            const SizedBox(width: kSpaceMd),
            NxButton(
              label: 'Filter',
              variant: NxButtonVariant.ghost,
              size: NxButtonSize.sm,
              icon: Icons.filter_list,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: kSpaceLg),
        // Quick capture bar
        const NxQuickCapture(),
        const SizedBox(height: kSpaceLg),
        // Task list
        Expanded(
          child: ListView.builder(
            itemCount: orderedGroups.length,
            itemBuilder: (context, i) {
              final groupName = orderedGroups[i];
              final tasks = groups[groupName]!;
              final isCompleted = groupName == 'COMPLETED';
              return NxTaskGroup(
                groupName: groupName,
                isOverdue: groupName == 'OVERDUE',
                tasks: tasks
                    .map(
                      (t) => NxTaskConfig(
                        title: t.title,
                        priorityColor: t.priority.color,
                        project: t.project,
                        projectColor: t.projectColor,
                        tags: t.tags,
                        dueLabel: t.dueLabel,
                        isCompleted: isCompleted,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

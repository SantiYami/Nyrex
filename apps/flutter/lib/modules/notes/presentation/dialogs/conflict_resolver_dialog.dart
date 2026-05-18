// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

enum ConflictResolution { keepMine, keepTheirs, mergeManual }

class ConflictResolverDialog extends StatelessWidget {
  final String noteTitle;
  final String? localContent;
  final String? serverContent;

  const ConflictResolverDialog({
    super.key,
    required this.noteTitle,
    this.localContent,
    this.serverContent,
  });

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return AlertDialog(
      backgroundColor: c.bg1,
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(width: kSpaceSm),
          Expanded(
            child: Text(
              'Conflict detected in "$noteTitle"',
              style: nxH1().copyWith(color: c.textHigh),
            ),
          ),
        ],
      ),
      content: Text(
        'Someone else modified this note while you were editing. Which version would you like to keep?',
        style: nxBody().copyWith(color: c.textHigh),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context, ConflictResolution.keepTheirs),
          child: const Text(
            'Discard my changes',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, ConflictResolution.keepMine),
          style: ElevatedButton.styleFrom(backgroundColor: kColorPrimary),
          child: const Text(
            'Overwrite Server',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NotesPage — Note viewer with mock content.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NxSectionHeader(
          breadcrumb: 'NOTES  /  Nyrex  /  Architecture',
          actions: [
            NxButton(
              label: 'Backlinks',
              variant: NxButtonVariant.ghost,
              size: NxButtonSize.sm,
              icon: Icons.link,
              onPressed: () {},
            ),
            const SizedBox(width: kSpaceSm),
            NxButton(
              label: 'Focus',
              variant: NxButtonVariant.ghost,
              size: NxButtonSize.sm,
              icon: Icons.center_focus_strong_outlined,
              onPressed: () {},
            ),
            const SizedBox(width: kSpaceSm),
            NxIconButton(icon: Icons.more_horiz, onPressed: () {}),
          ],
        ),
        const SizedBox(height: kSpace2xl),
        Expanded(child: SingleChildScrollView(child: _buildArticle(context))),
        _buildFooterHint(context),
      ],
    );
  }

  Widget _buildArticle(BuildContext context) {
    final c = NxColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nyrex Sync Layer',
          style: nxDisplay().copyWith(color: c.textHigh),
        ),
        const SizedBox(height: kSpaceSm),
        Text(
          'Architecture decision record — sync protocol design',
          style: nxSecondary().copyWith(color: c.textMedium),
        ),
        const SizedBox(height: kSpace2xl),
        Text('Overview', style: nxH2().copyWith(color: c.textHigh)),
        const SizedBox(height: kSpaceMd),
        Text(
          'The Nyrex sync layer uses a CRDT-based conflict resolution strategy '
          'with an append-only event log. Each device maintains a local vector '
          'clock, and changes are merged deterministically on the server.',
          style: nxBody().copyWith(color: c.textMedium, height: 1.7),
        ),
        const SizedBox(height: kSpaceLg),
        Text('Protocol Design', style: nxH2().copyWith(color: c.textHigh)),
        const SizedBox(height: kSpaceMd),
        Text(
          'Sync events are structured as immutable operations with a globally '
          'unique event ID (UUIDv7), a wall-clock timestamp, and a logical '
          'sequence number per device.',
          style: nxBody().copyWith(color: c.textMedium, height: 1.7),
        ),
        const SizedBox(height: kSpaceLg),
        const NxCodeBlock(
          code:
              'struct SyncEvent {\n    event_id: Uuid,\n    device_id: Uuid,\n'
              '    seq_no: u64,\n    timestamp: DateTime<Utc>,\n    op: Operation,\n'
              '    payload: EncryptedBlob,\n}',
        ),
        const SizedBox(height: kSpaceLg),
        Text('Backlinks', style: nxH2().copyWith(color: c.textHigh)),
        const SizedBox(height: kSpaceMd),
        Wrap(
          spacing: kSpaceSm,
          runSpacing: kSpaceSm,
          children: const [
            NxBacklinkPill(title: 'API design decisions'),
            NxBacklinkPill(title: 'Encryption protocol spec'),
          ],
        ),
        const SizedBox(height: kSpace3xl),
      ],
    );
  }

  Widget _buildFooterHint(BuildContext context) {
    final c = NxColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceLg,
        vertical: kSpaceSm,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.divider, width: 1)),
      ),
      child: Text(
        '/ for commands · [[ for note links · @ for tasks/finance',
        style: nxMonoSm().copyWith(color: c.textLow),
      ),
    );
  }
}

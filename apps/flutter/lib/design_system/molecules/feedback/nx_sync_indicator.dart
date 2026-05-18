// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxSyncIndicator — Synchronization status pill.
///
/// Composition: NxBadge variant representing sync state.
/// States: synced (teal), pending (yellow), offline (red).
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

enum NxSyncState { synced, pending, offline }

class NxSyncIndicator extends StatelessWidget {
  const NxSyncIndicator({super.key, required this.state});

  final NxSyncState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (state) {
      NxSyncState.synced => NxBadge(
        label: l10n.syncIndicatorSynced,
        variant: NxBadgeVariant.saved, // Confirmation/Teal
      ),
      NxSyncState.pending => NxBadge(
        label: l10n.syncStatusSyncing,
        variant: NxBadgeVariant.warning, // Warning/Yellow
      ),
      NxSyncState.offline => NxBadge(
        label: l10n.syncIndicatorOffline,
        variant: NxBadgeVariant.over, // Error/Red
      ),
    };
  }
}

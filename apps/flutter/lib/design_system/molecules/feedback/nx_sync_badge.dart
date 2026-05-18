// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxSyncBadge — Sync status badge with glowing dot indicator.
///
/// Composition: Glowing status dot + label text inside a bordered pill.
/// States: synced (green glow) or offline (dimmed).
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class NxSyncBadge extends StatelessWidget {
  const NxSyncBadge({super.key, this.isSynced = true});

  final bool isSynced;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpaceSm, vertical: 4),
      decoration: BoxDecoration(
        color: c.bg2,
        borderRadius: kRadiusDefault,
        border: Border.all(color: c.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isSynced ? kColorSuccess : c.textLow,
              shape: BoxShape.circle,
              boxShadow: isSynced
                  ? [
                      BoxShadow(
                        color: kColorSuccess.withAlpha(180),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: kSpaceSm),
          Text(
            isSynced ? l10n.syncStatusSynced : l10n.syncStatusOffline,
            style: nxMonoSm().copyWith(
              color: c.textLow,
              fontWeight: kWeightSemiBold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

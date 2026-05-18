// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxVaultDetailPane — Vault entry detail view.
///
/// Composition: Header (favicon + name + URL + kind) + field rows +
/// tags + metadata + delete action.
/// Used in Vault screen as the right pane.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

/// Configuration for a vault detail field.
class NxVaultField {
  const NxVaultField({
    required this.label,
    required this.value,
    this.isMasked = false,
  });

  final String label;
  final String value;
  final bool isMasked;
}

/// Full detail view for a vault entry.
class NxVaultDetailPane extends StatelessWidget {
  const NxVaultDetailPane({
    super.key,
    required this.name,
    required this.faviconAbbrev,
    this.url = '',
    this.kind = '',
    this.fields = const [],
    this.tags = const [],
    this.metadata = const [],
    this.onLaunch,
    this.onMore,
    this.onDelete,
    this.onFieldReveal,
    this.onFieldCopy,
  });

  final String name;
  final String faviconAbbrev;
  final String url;
  final String kind;
  final List<NxVaultField> fields;
  final List<String> tags;
  final List<NxMetaRow> metadata;
  final VoidCallback? onLaunch;
  final VoidCallback? onMore;
  final VoidCallback? onDelete;
  final void Function(String label)? onFieldReveal;
  final void Function(String label)? onFieldCopy;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context);
          final c = NxColors.of(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: c.bg2,
                      borderRadius: kRadiusMd,
                    ),
                    child: Center(
                      child: Text(
                        faviconAbbrev,
                        style: nxH2().copyWith(
                          color: c.textHigh,
                          fontWeight: kWeightBold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: kSpaceLg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: nxH1().copyWith(color: c.textHigh)),
                        if (url.isNotEmpty)
                          Text(
                            url,
                            style: nxSecondary().copyWith(color: c.textLow),
                          ),
                        Text(
                          kind,
                          style: nxCaption().copyWith(color: c.textLow),
                        ),
                      ],
                    ),
                  ),
                  if (onLaunch != null)
                    NxButton(
                      label: l10n.actionLaunch,
                      variant: NxButtonVariant.primary,
                      size: NxButtonSize.sm,
                      icon: Icons.open_in_new,
                      onPressed: onLaunch,
                    ),
                  if (onMore != null) ...[
                    const SizedBox(width: kSpaceSm),
                    NxIconButton(icon: Icons.more_horiz, onPressed: onMore!),
                  ],
                ],
              ),
              const SizedBox(height: kSpace2xl),
              // Fields
              ...fields.map(
                (f) => NxFieldRow(
                  label: f.label,
                  value: f.value,
                  isMasked: f.isMasked,
                  onReveal: f.isMasked && onFieldReveal != null
                      ? () => onFieldReveal!(f.label)
                      : null,
                  onCopy: onFieldCopy != null
                      ? () => onFieldCopy!(f.label)
                      : null,
                ),
              ),
              const SizedBox(height: kSpaceLg),
              // Tags
              if (tags.isNotEmpty) ...[
                Text(
                  l10n.labelTags,
                  style: nxMonoSm().copyWith(
                    color: c.textLow,
                    fontWeight: kWeightSemiBold,
                  ),
                ),
                const SizedBox(height: kSpaceSm),
                Wrap(
                  spacing: kSpaceSm,
                  children: tags
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: c.bg2,
                            borderRadius: kRadiusSm,
                          ),
                          child: Text(
                            t,
                            style: nxCaption().copyWith(color: c.textMedium),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: kSpace2xl),
              // Metadata
              if (metadata.isNotEmpty) ...[
                Text(
                  l10n.labelMetadata,
                  style: nxMonoSm().copyWith(
                    color: c.textLow,
                    fontWeight: kWeightSemiBold,
                  ),
                ),
                const SizedBox(height: kSpaceSm),
                ...metadata,
              ],
              const SizedBox(height: kSpace2xl),
              // Delete
              if (onDelete != null)
                NxButton(
                  label: l10n.actionDeleteEntry,
                  variant: NxButtonVariant.danger,
                  icon: Icons.delete_outline,
                  onPressed: onDelete,
                ),
            ],
          );
        },
      ),
    );
  }
}

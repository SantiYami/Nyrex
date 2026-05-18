// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxAuthLayout — Centered layout scaffold for authentication pages.
///
/// Provides a consistent frame for login/register pages with
/// centered content, constrained width, and branding header.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

/// A scaffold layout for authentication pages.
class NxAuthLayout extends StatelessWidget {
  const NxAuthLayout({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.maxWidth = 400,
  });

  /// The form content to display.
  final Widget child;

  /// The branding title. Falls back to localized app name if null.
  final String? title;

  /// Optional subtitle below the title.
  final String? subtitle;

  /// Maximum width of the content area.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context);
          final c = NxColors.of(context);

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kSpace2xl),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Branding
                    Text(
                      title ?? l10n.appName,
                      style: nxDisplay().copyWith(
                        color: kColorPrimary,
                        letterSpacing: 4,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: kSpaceSm),
                      Text(
                        subtitle!,
                        style: nxSecondary().copyWith(color: c.textMedium),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: kSpace4xl),
                    // Content
                    child,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

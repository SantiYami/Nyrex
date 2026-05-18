// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// FinancePage — Finance module placeholder.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NxSectionHeader(
          breadcrumb: 'FINANCE  /  Dashboard',
          actions: [
            NxButton(
              label: 'Add Transaction',
              variant: NxButtonVariant.ghost,
              size: NxButtonSize.sm,
              icon: Icons.add,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: kSpaceLg),
        Expanded(
          child: Center(
            child: Text(
              'Finance — Coming Soon',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      ],
    );
  }
}

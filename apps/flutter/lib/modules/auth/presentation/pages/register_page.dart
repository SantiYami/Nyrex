// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// RegisterPage — Registration page using NxAuthLayout scaffold.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/layouts/layouts.dart';
import 'package:nyrex/modules/auth/presentation/providers/auth_provider.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref
          .read(authStateProvider.notifier)
          .register(
            _emailController.text.trim(),
            _usernameController.text.trim(),
            _passwordController.text,
          );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).errorUnexpected)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authStateProvider);
    final c = NxColors.of(context);

    return NxAuthLayout(
      title: l10n.registerTitle,
      subtitle: l10n.registerSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.labelEmail,
                hintText: l10n.hintEmail,
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  (value == null || value.isEmpty) ? l10n.errorRequired : null,
            ),
            const SizedBox(height: kSpaceLg),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: l10n.labelUsername,
                prefixIcon: const Icon(Icons.person_outline, size: 20),
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? l10n.errorRequired : null,
            ),
            const SizedBox(height: kSpaceLg),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: l10n.labelPassword,
                hintText: l10n.hintPassword,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
              ),
              obscureText: true,
              validator: (value) => (value == null || value.length < 8)
                  ? l10n.errorPasswordTooShort
                  : null,
            ),
            const SizedBox(height: kSpace3xl),
            NxButton(
              label: l10n.actionRegister,
              onPressed: authState.isLoading ? null : _register,
            ),
            const SizedBox(height: kSpaceXl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.registerHaveAccount,
                  style: nxSecondary().copyWith(color: c.textMedium),
                ),
                NxButton(
                  variant: NxButtonVariant.ghost,
                  label: l10n.actionLogin,
                  onPressed: () => context.go('/login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';
import 'package:nyrex/modules/notes/presentation/providers/notes_provider.dart';
import 'package:nyrex/modules/vault/presentation/providers/vault_auth_provider.dart';

class NoteListPage extends ConsumerWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = NxColors.of(context);
    final notesState = ref.watch(notesStateProvider);
    final isLocked = ref.watch(vaultAuthStateProvider.notifier).isLocked;
    final l10n = AppLocalizations.of(context);

    // Any interaction resets the auto-lock timer
    return Listener(
      onPointerDown: (_) => ref.read(vaultAuthStateProvider.notifier).poke(),
      child: Scaffold(
        backgroundColor: c.bg0,
        appBar: AppBar(
          title: Text(l10n.appName),
          actions: [
            if (!isLocked)
              IconButton(
                icon: const Icon(Icons.lock_outline),
                onPressed: () =>
                    ref.read(vaultAuthStateProvider.notifier).lock(),
                tooltip: 'Lock Vault',
              ),
          ],
        ),
        body: isLocked
            ? const _UnlockView()
            : notesState.when(
                data: (notes) => notes.isEmpty
                    ? NxEmptyState(
                        icon: Icons.note_add_outlined,
                        title: 'Your Vault is empty',
                        description: 'Create your first encrypted note.',
                        actionLabel: 'Create Note',
                        onAction: () => context.go('/notes/edit'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(kSpaceLg),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: kSpaceMd),
                            child: NxItemCard(
                              title: note.title.isEmpty
                                  ? 'Untitled Note'
                                  : note.title,
                              subtitle: note.content.split('\n').first,
                              icon: Icons.description_outlined,
                              onTap: () =>
                                  context.go('/notes/edit?id=${note.id}'),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
        floatingActionButton: isLocked
            ? null
            : FloatingActionButton(
                onPressed: () => context.go('/notes/edit'),
                backgroundColor: kColorPrimary,
                child: const Icon(Icons.add, color: Colors.white),
              ),
      ),
    );
  }
}

class _UnlockView extends ConsumerStatefulWidget {
  const _UnlockView();

  @override
  ConsumerState<_UnlockView> createState() => _UnlockViewState();
}

class _UnlockViewState extends ConsumerState<_UnlockView> {
  final _passwordController = TextEditingController();

  Future<void> _unlock() async {
    final password = _passwordController.text;
    if (password.isNotEmpty) {
      await ref.read(vaultAuthStateProvider.notifier).unlock(password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Padding(
      padding: const EdgeInsets.all(kSpace2xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_rounded, size: 64, color: kColorPrimary),
          const SizedBox(height: kSpaceXl),
          Text(
            'The Vault is Locked',
            style: nxDisplay().copyWith(color: c.textHigh),
          ),
          const SizedBox(height: kSpaceSm),
          Text(
            'Enter your master password to decrypt your notes.',
            textAlign: TextAlign.center,
            style: nxSecondary().copyWith(color: c.textMedium),
          ),
          const SizedBox(height: kSpace2xl),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Master Password',
              prefixIcon: Icon(Icons.password),
              border: OutlineInputBorder(borderRadius: kRadiusSm),
            ),
            onSubmitted: (_) => _unlock(),
          ),
          const SizedBox(height: kSpaceXl),
          NxButton(
            variant: NxButtonVariant.primary,
            label: 'Unlock Vault',
            onPressed: _unlock,
          ),
        ],
      ),
    );
  }
}

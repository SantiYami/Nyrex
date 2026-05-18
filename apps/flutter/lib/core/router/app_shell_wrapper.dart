// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nyrex/core/data/mock_data.dart';
import 'package:nyrex/core/providers/focus_mode_provider.dart';
import 'package:nyrex/design_system/organisms/organisms.dart';
import 'package:nyrex/modules/home/presentation/widgets/home_sidebar.dart';
import 'package:nyrex/modules/notes/presentation/widgets/notes_sidebar.dart';
import 'package:nyrex/modules/vault/presentation/widgets/vault_sidebar.dart';
import 'package:nyrex/modules/tasks/presentation/widgets/tasks_sidebar.dart';

class AppShellWrapper extends ConsumerWidget {
  const AppShellWrapper({super.key, required this.child, required this.state});

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = state.uri.path;

    bool isActive(String path) => location.startsWith(path);

    void navigate(String path) => context.go(path);

    void showCommandPalette() {
      NxCommandPalette.show(
        context,
        results: kMockCommandIndex.map((c) {
          return NxCommandResult(
            title: c.title,
            subtitle: c.subtitle,
            icon: c.icon,
            group: c.group,
            shortcut: c.shortcut,
            onSelected: () {
              if (c.route != null) {
                context.go(c.route!);
              } else if (c.title == 'Toggle Focus Mode') {
                ref.read(focusModeProvider.notifier).toggle();
              }
            },
          );
        }).toList(),
      );
    }

    final isFocusMode = ref.watch(focusModeProvider);

    // Build module-specific sidebar content
    Widget? sidebarContent;
    if (isActive('/home')) {
      sidebarContent = HomeSidebar(
        onSearchTap: showCommandPalette,
        onQuickCaptureTap: () => navigate('/notes/edit'),
        onNavigate: navigate,
      );
    } else if (isActive('/notes')) {
      sidebarContent = NotesSidebar(
        onSearchTap: showCommandPalette,
        onNewNoteTap: () => navigate('/notes/edit'),
      );
    } else if (isActive('/vault')) {
      sidebarContent = VaultSidebar(
        onSearchTap: showCommandPalette,
        onNewEntryTap: () {},
      );
    } else if (isActive('/tasks')) {
      sidebarContent = TasksSidebar(
        onSearchTap: showCommandPalette,
        onQuickCaptureTap: () {},
      );
    } else if (isActive('/finance')) {
      sidebarContent = const Center(
        child: Text(
          'Finance sidebar\nComing soon',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF555568), fontSize: 12),
        ),
      );
    }

    final isMac = defaultTargetPlatform == TargetPlatform.macOS;
    final modKey = isMac ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control;

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(modKey, LogicalKeyboardKey.keyK):
            const CommandPaletteIntent(),
        LogicalKeySet(
          modKey,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.keyF,
        ): const FocusModeIntent(),
        LogicalKeySet(modKey, LogicalKeyboardKey.keyN): const NewNoteIntent(),
        LogicalKeySet(modKey, LogicalKeyboardKey.keyE):
            const LogExpenseIntent(),
      },
      child: Actions(
        actions: {
          CommandPaletteIntent: CallbackAction<CommandPaletteIntent>(
            onInvoke: (_) => showCommandPalette(),
          ),
          FocusModeIntent: CallbackAction<FocusModeIntent>(
            onInvoke: (_) => ref.read(focusModeProvider.notifier).toggle(),
          ),
          NewNoteIntent: CallbackAction<NewNoteIntent>(
            onInvoke: (_) => navigate('/notes/edit'),
          ),
          LogExpenseIntent: CallbackAction<LogExpenseIntent>(
            onInvoke: (_) => navigate('/finance'),
          ),
        },
        child: Focus(
          autofocus: true,
          onKeyEvent: (node, event) {
            // Numeric shortcuts 1-5 for module switching
            if (event is KeyDownEvent &&
                !HardwareKeyboard.instance.isControlPressed &&
                !HardwareKeyboard.instance.isMetaPressed) {
              final key = event.logicalKey;
              if (key == LogicalKeyboardKey.digit1) {
                navigate('/home');
                return KeyEventResult.handled;
              }
              if (key == LogicalKeyboardKey.digit2) {
                navigate('/notes');
                return KeyEventResult.handled;
              }
              if (key == LogicalKeyboardKey.digit3) {
                navigate('/vault');
                return KeyEventResult.handled;
              }
              if (key == LogicalKeyboardKey.digit4) {
                navigate('/tasks');
                return KeyEventResult.handled;
              }
              if (key == LogicalKeyboardKey.digit5) {
                navigate('/finance');
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: NxAppShell(
            isFocusMode: isFocusMode,
            onCommandPaletteRequested: showCommandPalette,
            railItems: [
              NxRailItem(
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () => navigate('/home'),
                isActive: isActive('/home'),
              ),
              NxRailItem(
                icon: Icons.edit_note_outlined,
                label: 'Notes',
                onTap: () => navigate('/notes'),
                isActive: isActive('/notes'),
              ),
              NxRailItem(
                icon: Icons.lock_outlined,
                label: 'Vault',
                onTap: () => navigate('/vault'),
                isActive: isActive('/vault'),
              ),
              NxRailItem(
                icon: Icons.check_circle_outline,
                label: 'Tasks',
                onTap: () => navigate('/tasks'),
                isActive: isActive('/tasks'),
              ),
              NxRailItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Finance',
                onTap: () => navigate('/finance'),
                isActive: isActive('/finance'),
              ),
            ],
            bottomRailItem: NxRailItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {},
              isActive: isActive('/settings'),
            ),
            sidebarContent: sidebarContent,
            child: child,
          ),
        ),
      ),
    );
  }
}

class CommandPaletteIntent extends Intent {
  const CommandPaletteIntent();
}

class FocusModeIntent extends Intent {
  const FocusModeIntent();
}

class NewNoteIntent extends Intent {
  const NewNoteIntent();
}

class LogExpenseIntent extends Intent {
  const LogExpenseIntent();
}

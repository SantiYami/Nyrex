// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
///
/// Declarative routing configuration using GoRouter.
library;

import 'package:go_router/go_router.dart';
import 'package:nyrex/core/router/app_shell_wrapper.dart';
import 'package:nyrex/modules/auth/presentation/pages/login_page.dart';
import 'package:nyrex/modules/auth/presentation/pages/register_page.dart';
import 'package:nyrex/modules/finance/presentation/pages/finance_page.dart';
import 'package:nyrex/modules/home/presentation/pages/home_dashboard_page.dart';
import 'package:nyrex/modules/notes/presentation/pages/note_editor_page.dart';
import 'package:nyrex/modules/notes/presentation/pages/notes_page.dart';
import 'package:nyrex/modules/tasks/presentation/pages/tasks_page.dart';
import 'package:nyrex/modules/vault/presentation/pages/vault_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      // Shell — wraps all module content
      ShellRoute(
        builder: (context, state, child) =>
            AppShellWrapper(state: state, child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeDashboardPage(),
          ),
          GoRoute(
            path: '/notes',
            builder: (context, state) => const NotesPage(),
          ),
          GoRoute(
            path: '/notes/edit',
            builder: (context, state) {
              final idStr = state.uri.queryParameters['id'];
              final id = idStr != null ? int.tryParse(idStr) : null;
              return NoteEditorPage(noteId: id);
            },
          ),
          GoRoute(
            path: '/vault',
            builder: (context, state) => const VaultPage(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksPage(),
          ),
          GoRoute(
            path: '/finance',
            builder: (context, state) => const FinancePage(),
          ),
        ],
      ),
    ],
  );
}

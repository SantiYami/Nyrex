// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyrex/core/router/app_router.dart';
import 'package:nyrex/design_system/theme/app_theme.dart';
import 'package:nyrex/design_system/theme/theme_provider.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

void main() {
  // Ensures that Flutter services (native channels) are ready
  // before initializing anything else. Crucial for storage or plugins.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // ProviderScope lives at the root of the app.
    // It's the Riverpod container that stores all providers (state).
    const ProviderScope(child: NyrexApp()),
  );
}

class NyrexApp extends ConsumerWidget {
  const NyrexApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We listen to the providers we defined. If the theme or router changes,
    // this widget will rebuild automatically.
    final router = ref.watch(appRouterProvider);
    final themeVariant = ref.watch(themeProvider);

    // .router allows us to use GoRouter for declarative navigation.
    // Instead of manual navigation stacks, we define routes like in web (/login, /home).
    return MaterialApp.router(
      title: 'Nyrex',
      debugShowCheckedModeBanner: false,

      // Link the Router configuration
      routerConfig: router,

      // Apply the selected theme variant (Dark, Light, AMOLED)
      theme: AppTheme.of(themeVariant),

      // Internationalization setup
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

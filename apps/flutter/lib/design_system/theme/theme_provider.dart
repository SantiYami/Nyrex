// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
///
/// Riverpod provider that manages the active [NyrexThemeVariant].
/// The selection is persisted in shared preferences so it survives
/// app restarts.
library;

import 'package:nyrex/design_system/theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const _kThemeKey = 'nyrex_theme_variant';

/// Exposes the resolved [ThemeData] for the current variant.
/// Built on top of [themeVariantProvider].
@riverpod
NyrexThemeVariant themeVariant(Ref ref) {
  // Default to dark; will be overridden by [ThemeNotifier].
  return NyrexThemeVariant.dark;
}

/// Manages persistence and state changes for the theme variant.
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  NyrexThemeVariant build() {
    _loadPersistedVariant();
    return NyrexThemeVariant.dark;
  }

  Future<void> setVariant(NyrexThemeVariant variant) async {
    state = variant;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeKey, variant.name);
  }

  Future<void> _loadPersistedVariant() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kThemeKey);
    if (raw == null) return;

    final variant = NyrexThemeVariant.values.firstWhere(
      (v) => v.name == raw,
      orElse: () => NyrexThemeVariant.dark,
    );
    state = variant;
  }
}

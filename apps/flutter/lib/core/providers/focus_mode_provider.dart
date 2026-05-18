// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_mode_provider.g.dart';

@riverpod
class FocusMode extends _$FocusMode {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }

  void enable() {
    state = true;
  }

  void disable() {
    state = false;
  }
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

abstract class AppLogger {
  void debug(String message, {Object? error, StackTrace? stackTrace});
  void info(String message);
  void warning(String message, {Object? error, StackTrace? stackTrace});
  void error(String message, {Object? error, StackTrace? stackTrace});
  void fatal(String message, {Object? error, StackTrace? stackTrace});
}

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Central DI barrel — export all core providers for easy overrides in tests.
library;

export 'package:nyrex/core/database/app_database.dart' show appDatabaseProvider;
export 'package:nyrex/core/logger/logger_provider.dart' show loggerProvider;

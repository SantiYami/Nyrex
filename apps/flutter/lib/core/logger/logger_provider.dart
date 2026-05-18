// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_logger.dart';
import 'impl/console_logger.dart';

part 'logger_provider.g.dart';

@riverpod
AppLogger logger(Ref ref) {
  final logger = Logger(level: kReleaseMode ? Level.warning : Level.debug);

  return ConsoleLogger(logger);
}

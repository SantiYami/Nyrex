// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:io';

import 'package:flutter/foundation.dart';

abstract final class ApiConstants {
  ApiConstants._();

  /// The base URL for the backend API.
  /// Handles localhost differences between Windows and Android emulators.
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else {
      // Windows / macOS / iOS
      return 'http://localhost:3000';
    }
  }

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}

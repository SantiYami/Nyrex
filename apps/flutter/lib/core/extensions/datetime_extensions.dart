// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

extension DateTimeX on DateTime {
  String toIso8601StringWithZ() => '${toIso8601String()}Z';
}

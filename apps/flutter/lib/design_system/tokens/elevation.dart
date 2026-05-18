// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Elevation tokens for Nyrex.
///
/// Defines consistent box-shadow levels used across the design system.
/// Level 0 = flat, Level 4 = highest prominence (modals, command palette).
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Elevation levels
// ---------------------------------------------------------------------------

/// Level 0 — Flat, no shadow (default for cards within bg-2).
const List<BoxShadow> kElevation0 = [];

/// Level 1 — Subtle lift (tooltips, dropdown menus).
const List<BoxShadow> kElevation1 = [
  BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
];

/// Level 2 — Medium prominence (floating action panels, popovers).
const List<BoxShadow> kElevation2 = [
  BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 4)),
  BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
];

/// Level 3 — High prominence (modals, sheets).
const List<BoxShadow> kElevation3 = [
  BoxShadow(color: Color(0x33000000), blurRadius: 16, offset: Offset(0, 8)),
  BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
];

/// Level 4 — Maximum prominence (command palette, overlays).
const List<BoxShadow> kElevation4 = [
  BoxShadow(color: Color(0x40000000), blurRadius: 24, offset: Offset(0, 12)),
  BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 3)),
];

// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Border-radius tokens for Nyrex.
///
/// Mapped from design spec:
///   sm(4) → DEFAULT(8) → md(12) → lg(16) → xl(24) → full(9999).
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Raw radius values
// ---------------------------------------------------------------------------

/// 4px — badges, kbd hints, chips.
const double kRadiusSmValue = 4;

/// 8px — buttons, inputs, dropdowns.
const double kRadiusDefaultValue = 8;

/// 12px — compact cards, table rows.
const double kRadiusMdValue = 12;

/// 16px — structural panels, modals.
const double kRadiusLgValue = 16;

/// 24px — full-screen overlays, command palette.
const double kRadiusXlValue = 24;

/// 9999px — circular badges, pills.
const double kRadiusFullValue = 9999;

// ---------------------------------------------------------------------------
// BorderRadius constants
// ---------------------------------------------------------------------------

/// 4px — badges, kbd hints, chips.
const BorderRadius kRadiusSm = BorderRadius.all(
  Radius.circular(kRadiusSmValue),
);

/// 8px — buttons, inputs, dropdowns.
const BorderRadius kRadiusDefault = BorderRadius.all(
  Radius.circular(kRadiusDefaultValue),
);

/// 12px — compact cards, table rows.
const BorderRadius kRadiusMd = BorderRadius.all(
  Radius.circular(kRadiusMdValue),
);

/// 16px — structural panels, modals.
const BorderRadius kRadiusLg = BorderRadius.all(
  Radius.circular(kRadiusLgValue),
);

/// 24px — full-screen overlays, command palette.
const BorderRadius kRadiusXl = BorderRadius.all(
  Radius.circular(kRadiusXlValue),
);

/// Pill shape — fully rounded.
const BorderRadius kRadiusFull = BorderRadius.all(
  Radius.circular(kRadiusFullValue),
);

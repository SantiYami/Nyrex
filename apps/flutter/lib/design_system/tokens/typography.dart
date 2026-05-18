// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Typography tokens for Nyrex.
///
/// UI font: Inter (via google_fonts).
/// Mono font: JetBrains Mono (via google_fonts) with tabular figures.
///
/// Scale follows the Design Prompt:
///   display(28/700) → h1(22/600) → h2(17/600) → h3(14/600)
///   → body(14/400) → secondary(13/400) → caption(11/400) → mono(12/400)
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// ---------------------------------------------------------------------------
// Font weights
// ---------------------------------------------------------------------------
const FontWeight kWeightRegular = FontWeight.w400;
const FontWeight kWeightMedium = FontWeight.w500;
const FontWeight kWeightSemiBold = FontWeight.w600;
const FontWeight kWeightBold = FontWeight.w700;

// ---------------------------------------------------------------------------
// Base TextStyle factories
// ---------------------------------------------------------------------------

/// Returns the Inter [TextStyle] base with Google Fonts applied.
TextStyle _inter({
  required double fontSize,
  required FontWeight fontWeight,
  double? letterSpacing,
  double? height,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    height: height,
  );
}

/// Returns the JetBrains Mono [TextStyle] with tabular figures.
TextStyle _mono({
  required double fontSize,
  FontWeight fontWeight = kWeightRegular,
  double? height,
}) {
  return GoogleFonts.jetBrainsMono(
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

// ---------------------------------------------------------------------------
// Named style factories (no color — applied via TextTheme)
// ---------------------------------------------------------------------------

/// Display · 28/700 · Page titles.
TextStyle nxDisplay() => _inter(
  fontSize: 28,
  fontWeight: kWeightBold,
  letterSpacing: -0.56, // -0.02em
  height: 1.2,
);

/// H1 · 22/600 · Section heads.
TextStyle nxH1() => _inter(
  fontSize: 22,
  fontWeight: kWeightSemiBold,
  letterSpacing: -0.22, // -0.01em
  height: 1.3,
);

/// H2 · 17/600 · Subsections.
TextStyle nxH2() => _inter(
  fontSize: 17,
  fontWeight: kWeightSemiBold,
  letterSpacing: -0.17, // -0.01em
  height: 1.4,
);

/// H3 · 14/600 · Labels, group titles.
TextStyle nxH3() =>
    _inter(fontSize: 14, fontWeight: kWeightSemiBold, height: 1.4);

/// Body · 14/400 · Default content.
TextStyle nxBody() =>
    _inter(fontSize: 14, fontWeight: kWeightRegular, height: 1.5);

/// Secondary · 13/400 · Metadata, timestamps.
TextStyle nxSecondary() =>
    _inter(fontSize: 13, fontWeight: kWeightRegular, height: 1.5);

/// Caption · 11/400 · Fine print, badges.
TextStyle nxCaption() =>
    _inter(fontSize: 11, fontWeight: kWeightRegular, height: 1.4);

/// Mono · 12/400 · Financial amounts, IDs, kbd shortcuts.
/// Always uses JetBrains Mono with tabular figures.
TextStyle nxMono() => _mono(fontSize: 12, height: 1.2);

/// Mono Small · 10/400 · Timestamps, fine metadata.
TextStyle nxMonoSm() => _mono(fontSize: 10, height: 1.2);

/// Mono Caption · 11/400 · Sidebar counts, subtle data.
TextStyle nxMonoCap() => _mono(fontSize: 11, height: 1.2);

/// Mono Large · 14/600 · Prominent financial figures.
TextStyle nxMonoLg() =>
    _mono(fontSize: 14, fontWeight: kWeightSemiBold, height: 1.2);

// ---------------------------------------------------------------------------
// TextTheme factory
// ---------------------------------------------------------------------------

/// Builds a complete [TextTheme] using Inter + JetBrains Mono.
///
/// Colors are applied based on [isDark] flag.
TextTheme buildNxTextTheme({required bool isDark}) {
  final high = isDark ? kColorTextHigh : kColorTextHighLight;
  final medium = isDark ? kColorTextMedium : kColorTextMediumLight;

  return TextTheme(
    // Display
    displayLarge: nxDisplay().copyWith(color: high),
    displayMedium: nxH1().copyWith(color: high),

    // Headline
    headlineLarge: nxH1().copyWith(color: high),
    headlineMedium: nxH2().copyWith(color: high),

    // Title
    titleLarge: nxH2().copyWith(color: high),
    titleMedium: nxH3().copyWith(color: high),

    // Body
    bodyLarge: nxBody().copyWith(color: high),
    bodyMedium: nxSecondary().copyWith(color: medium),

    // Label
    labelLarge: nxH3().copyWith(color: high),
    labelMedium: nxCaption().copyWith(color: medium),
    labelSmall: nxCaption().copyWith(color: medium, letterSpacing: 0.4),
  );
}

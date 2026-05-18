// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Breakpoint tokens for Nyrex.
///
/// Defines responsive layout breakpoints for adaptive design.
/// Based on Material Design 3 breakpoint system.
library;

// ---------------------------------------------------------------------------
// Width breakpoints (in logical pixels)
// ---------------------------------------------------------------------------

/// Compact — phones in portrait (< 600).
const double kBreakpointCompact = 600;

/// Medium — tablets, small laptops (600–840).
const double kBreakpointMedium = 840;

/// Expanded — desktops, large tablets (840–1200).
const double kBreakpointExpanded = 1200;

/// Large — wide desktops (1200–1600).
const double kBreakpointLarge = 1600;

/// Extra-large — ultra-wide monitors (> 1600).
const double kBreakpointExtraLarge = 1600;

// ---------------------------------------------------------------------------
// Layout helpers
// ---------------------------------------------------------------------------

/// Whether the given width is compact (mobile).
bool isCompact(double width) => width < kBreakpointCompact;

/// Whether the given width is medium (tablet).
bool isMedium(double width) =>
    width >= kBreakpointCompact && width < kBreakpointMedium;

/// Whether the given width is expanded (desktop).
bool isExpanded(double width) =>
    width >= kBreakpointMedium && width < kBreakpointExpanded;

/// Whether the given width is large (wide desktop).
bool isLarge(double width) => width >= kBreakpointExpanded;

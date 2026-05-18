// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Motion tokens for Nyrex.
///
/// Defines consistent animation durations and curves used across
/// the design system for micro-interactions and transitions.
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Durations
// ---------------------------------------------------------------------------

/// Instant feedback — checkbox taps, toggle flips.
const Duration kDurationFast = Duration(milliseconds: 100);

/// Standard transitions — hover states, color changes, fade-ins.
const Duration kDurationDefault = Duration(milliseconds: 200);

/// Moderate transitions — panel slides, card expansions.
const Duration kDurationMedium = Duration(milliseconds: 300);

/// Slow transitions — page transitions, modals, command palette.
const Duration kDurationSlow = Duration(milliseconds: 400);

// ---------------------------------------------------------------------------
// Curves
// ---------------------------------------------------------------------------

/// Default easing — most UI transitions.
const Curve kCurveDefault = Curves.easeInOut;

/// Deceleration — elements entering the screen (slide in, fade in).
const Curve kCurveDecelerate = Curves.decelerate;

/// Acceleration — elements exiting the screen (slide out, fade out).
const Curve kCurveAccelerate = Curves.easeIn;

/// Emphasized — prominent transitions (modals, overlays).
const Curve kCurveEmphasized = Curves.easeOutCubic;

/// Spring-like — playful micro-interactions.
const Curve kCurveSpring = Curves.elasticOut;

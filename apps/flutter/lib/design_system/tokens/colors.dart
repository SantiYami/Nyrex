// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// Color tokens for Nyrex.
///
/// Organized by role:
///   01 · Surface scale (bg-0, bg-1, bg-2, border, divider)
///   02 · Brand (primary, confirmation)
///   03 · Text (high, medium, low emphasis)
///   04 · Semantic (success, warning, error, info)
///
/// Rule: Violet = power/selection. Teal = confirmation. Semantic = status only.
/// NEVER hardcode hex values in widgets — always use these constants.
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// 01 · Brand
// ---------------------------------------------------------------------------

/// Primary accent — CTAs, active states, selection, focus rings.
const Color kColorPrimary = Color(0xFF7C6AF7);

/// Hover state for primary elements.
const Color kColorPrimaryHover = Color(0xFF5A4FD6);

/// Muted primary — active nav backgrounds, subtle tinted fills.
const Color kColorPrimaryMuted = Color(0xFF3D3499);

/// Soft primary — acc-soft, active selection backgrounds.
/// rgba(124,106,247,0.14)
const Color kColorPrimarySoft = Color(0x247C6AF7);

/// Accent text — sidebar active text, command palette selected text.
const Color kColorAccentText = Color(0xFFAFA9EC);

/// Confirmation teal — completed actions, positive state.
const Color kColorConfirmation = Color(0xFF00D4AA);

// ---------------------------------------------------------------------------
// 02 · Dark theme surfaces (canonical)
// ---------------------------------------------------------------------------

/// bg-0 · App canvas, root layer.
const Color kColorDarkBg0 = Color(0xFF0F0F14);

/// bg-1 · Sidebars, panels, modals.
const Color kColorDarkBg1 = Color(0xFF1A1A24);

/// bg-2 · Cards, elevated elements, popovers.
const Color kColorDarkBg2 = Color(0xFF22222F);

/// Structural borders — input borders, card strokes.
const Color kColorDarkBorder = Color(0xFF2E2E3E);

/// Subtle dividers — list separators, section boundaries.
const Color kColorDarkDivider = Color(0xFF252535);

// ---------------------------------------------------------------------------
// 03 · AMOLED surfaces (pure black override)
// ---------------------------------------------------------------------------

const Color kColorAmoledBg0 = Color(0xFF000000);
const Color kColorAmoledBg1 = Color(0xFF0A0A0A);
const Color kColorAmoledBg2 = Color(0xFF111111);
const Color kColorAmoledBorder = Color(0xFF1C1C1C);

// ---------------------------------------------------------------------------
// 04 · Light surfaces (override)
// ---------------------------------------------------------------------------

const Color kColorLightBg0 = Color(0xFFF4F4FA);
const Color kColorLightBg1 = Color(0xFFFFFFFF);
const Color kColorLightBg2 = Color(0xFFF0F0FA);
const Color kColorLightBorder = Color(0xFFE0E0F0);
const Color kColorLightDivider = Color(0xFFEEEEFF);

// ---------------------------------------------------------------------------
// 05 · Text (brightness-aware)
// ---------------------------------------------------------------------------

/// High emphasis (dark mode).
const Color kColorTextHigh = Color(0xFFE8E8F0);

/// Medium emphasis (dark mode).
const Color kColorTextMedium = Color(0xFF9090A8);

/// Low / disabled emphasis (dark mode).
const Color kColorTextLow = Color(0xFF555568);

/// High emphasis (light mode).
const Color kColorTextHighLight = Color(0xFF1A1A2E);

/// Medium emphasis (light mode).
const Color kColorTextMediumLight = Color(0xFF555570);

/// Low / disabled emphasis (light mode).
const Color kColorTextLowLight = Color(0xFFAAAAAC);

// ---------------------------------------------------------------------------
// 06 · Semantic (status only, never decorative)
// ---------------------------------------------------------------------------

/// Within limits, healthy.
const Color kColorSuccess = Color(0xFF3DDC84);

/// Early warning, approaching threshold.
const Color kColorWarning = Color(0xFFFFC947);

/// Exceeded, deficit, overdue, validation error.
const Color kColorError = Color(0xFFFF5C5C);

/// Informational.
const Color kColorInfo = Color(0xFF4DA6FF);

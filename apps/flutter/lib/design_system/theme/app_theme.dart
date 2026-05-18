// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
///
/// Builds a [ThemeData] for each [NyrexThemeVariant].
/// All values are derived from the design tokens in `tokens/`.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

/// Variants supported by Nyrex.
/// Add new variants here — no other file needs to change.
enum NyrexThemeVariant { dark, light, amoled }

/// Returns the human-readable label for a given variant.
extension NyrexThemeVariantLabel on NyrexThemeVariant {
  String get label {
    switch (this) {
      case NyrexThemeVariant.dark:
        return 'Dark';
      case NyrexThemeVariant.light:
        return 'Light';
      case NyrexThemeVariant.amoled:
        return 'AMOLED';
    }
  }

  bool get isDark => this != NyrexThemeVariant.light;
}

/// Factory that produces a [ThemeData] from a [NyrexThemeVariant].
abstract final class AppTheme {
  AppTheme._();

  static ThemeData of(NyrexThemeVariant variant) {
    switch (variant) {
      case NyrexThemeVariant.dark:
        return _build(
          brightness: Brightness.dark,
          bg0: kColorDarkBg0,
          bg1: kColorDarkBg1,
          bg2: kColorDarkBg2,
          border: kColorDarkBorder,
          divider: kColorDarkDivider,
        );
      case NyrexThemeVariant.amoled:
        return _build(
          brightness: Brightness.dark,
          bg0: kColorAmoledBg0,
          bg1: kColorAmoledBg1,
          bg2: kColorAmoledBg2,
          border: kColorAmoledBorder,
          divider: kColorAmoledBorder,
        );
      case NyrexThemeVariant.light:
        return _build(
          brightness: Brightness.light,
          bg0: kColorLightBg0,
          bg1: kColorLightBg1,
          bg2: kColorLightBg2,
          border: kColorLightBorder,
          divider: kColorLightDivider,
        );
    }
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color bg0,
    required Color bg1,
    required Color bg2,
    required Color border,
    required Color divider,
  }) {
    final isDark = brightness == Brightness.dark;
    final textTheme = buildNxTextTheme(isDark: isDark);
    final onSurface = isDark ? kColorTextHigh : kColorTextHighLight;
    final onSurfaceVariant = isDark ? kColorTextMedium : kColorTextMediumLight;
    final textLow = isDark ? kColorTextLow : kColorTextLowLight;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: kColorPrimary,
        onPrimary: Colors.white,
        primaryContainer: kColorPrimaryMuted,
        onPrimaryContainer: kColorTextHigh,
        secondary: kColorConfirmation,
        onSecondary: Colors.black,
        secondaryContainer: kColorConfirmation.withAlpha(30),
        onSecondaryContainer: kColorConfirmation,
        error: kColorError,
        onError: Colors.white,
        surface: bg1,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: border,
        outlineVariant: divider,
        shadow: Colors.black,
        scrim: Colors.black54,
        inverseSurface: isDark ? Colors.white : kColorDarkBg0,
        onInverseSurface: isDark ? kColorDarkBg0 : Colors.white,
        inversePrimary: kColorPrimaryHover,
      ),
      scaffoldBackgroundColor: bg0,
      cardColor: bg2,
      dividerColor: divider,
      textTheme: textTheme,
      // -------------------------------------------------------------------
      // AppBar
      // -------------------------------------------------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: bg0,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.titleLarge,
        centerTitle: false,
      ),
      // -------------------------------------------------------------------
      // Cards — bg-2, border, r12
      // -------------------------------------------------------------------
      cardTheme: CardThemeData(
        color: bg2,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: kRadiusMd,
          side: BorderSide(color: border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      // -------------------------------------------------------------------
      // Input fields — bg-0 fill, r8, 36px height
      // -------------------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bg0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kSpaceMd,
          vertical: kSpaceMd,
        ),
        border: OutlineInputBorder(
          borderRadius: kRadiusDefault,
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: kRadiusDefault,
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: kRadiusDefault,
          borderSide: BorderSide(color: kColorPrimary, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: kRadiusDefault,
          borderSide: BorderSide(color: kColorError),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: kRadiusDefault,
          borderSide: BorderSide(color: kColorError, width: 2),
        ),
        labelStyle: TextStyle(color: onSurfaceVariant),
        hintStyle: TextStyle(color: onSurfaceVariant),
      ),
      // -------------------------------------------------------------------
      // Buttons — primary fill, 36px standard / 32px compact
      // -------------------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(
            vertical: kSpaceMd,
            horizontal: kSpace2xl,
          ),
          shape: const RoundedRectangleBorder(borderRadius: kRadiusDefault),
          textStyle: nxH3(),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kColorPrimary,
          textStyle: nxSecondary().copyWith(fontWeight: kWeightMedium),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kColorPrimary,
          side: const BorderSide(color: kColorPrimary),
          shape: const RoundedRectangleBorder(borderRadius: kRadiusDefault),
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(
            vertical: kSpaceMd,
            horizontal: kSpace2xl,
          ),
        ),
      ),
      // -------------------------------------------------------------------
      // Misc
      // -------------------------------------------------------------------
      dividerTheme: DividerThemeData(color: divider, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(
        tileColor: bg2,
        shape: RoundedRectangleBorder(borderRadius: kRadiusMd),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: bg2,
        contentTextStyle: textTheme.bodyMedium,
        shape: const RoundedRectangleBorder(borderRadius: kRadiusDefault),
        behavior: SnackBarBehavior.floating,
      ),
      // -------------------------------------------------------------------
      // Dialog — bg-1 fill, r16, subtle border
      // -------------------------------------------------------------------
      dialogTheme: DialogThemeData(
        backgroundColor: bg1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: kRadiusLg,
          side: BorderSide(color: border),
        ),
        titleTextStyle: nxH2().copyWith(color: onSurface),
        contentTextStyle: nxBody().copyWith(color: onSurfaceVariant),
      ),
      // -------------------------------------------------------------------
      // Bottom Sheet — bg-1, top r24
      // -------------------------------------------------------------------
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bg1,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kRadiusXlValue),
          ),
        ),
      ),
      // -------------------------------------------------------------------
      // Chip — bg-2, sm radius, border
      // -------------------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: bg2,
        labelStyle: nxSecondary().copyWith(color: onSurface),
        side: BorderSide(color: border),
        shape: const RoundedRectangleBorder(borderRadius: kRadiusSm),
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceSm,
          vertical: kSpaceXs,
        ),
      ),
      // -------------------------------------------------------------------
      // Switch — primary track when on
      // -------------------------------------------------------------------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return kColorPrimary;
          return onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kColorPrimary.withAlpha(80);
          }
          return border;
        }),
      ),
      // -------------------------------------------------------------------
      // Checkbox — primary fill when checked
      // -------------------------------------------------------------------
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return kColorPrimary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.resolveWith((_) => Colors.white),
        side: BorderSide(color: border),
        shape: const RoundedRectangleBorder(borderRadius: kRadiusSm),
      ),
      // -------------------------------------------------------------------
      // Popup Menu — bg-1, r12, elevation-3
      // -------------------------------------------------------------------
      popupMenuTheme: PopupMenuThemeData(
        color: bg1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: kRadiusMd,
          side: BorderSide(color: border),
        ),
        elevation: 3,
        shadowColor: Colors.black,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (_) => nxBody().copyWith(color: onSurface),
        ),
      ),
      // -------------------------------------------------------------------
      // Tooltip — bg-2, sm radius
      // -------------------------------------------------------------------
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: bg2, borderRadius: kRadiusSm),
        textStyle: nxCaption().copyWith(color: onSurface),
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceSm,
          vertical: kSpaceXs,
        ),
      ),
      // -------------------------------------------------------------------
      // Progress Indicator — primary track
      // -------------------------------------------------------------------
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kColorPrimary,
        linearTrackColor: border,
        circularTrackColor: border,
      ),
      // -------------------------------------------------------------------
      // Slider — primary active track
      // -------------------------------------------------------------------
      sliderTheme: SliderThemeData(
        activeTrackColor: kColorPrimary,
        inactiveTrackColor: border,
        thumbColor: kColorPrimary,
        overlayColor: kColorPrimary.withAlpha(30),
        valueIndicatorColor: bg2,
        valueIndicatorTextStyle: nxCaption().copyWith(color: onSurface),
      ),
      // -------------------------------------------------------------------
      // Search Bar — bg-0, border, r8
      // -------------------------------------------------------------------
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(bg0),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: kRadiusDefault),
        ),
        side: WidgetStateProperty.all(BorderSide(color: border)),
        textStyle: WidgetStateProperty.all(nxBody().copyWith(color: onSurface)),
        hintStyle: WidgetStateProperty.all(
          nxBody().copyWith(color: onSurfaceVariant),
        ),
      ),
      // -------------------------------------------------------------------
      // Menu / MenuBar — desktop context menus
      // -------------------------------------------------------------------
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(bg1),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: kRadiusMd,
              side: BorderSide(color: border),
            ),
          ),
          elevation: WidgetStateProperty.all(3),
          shadowColor: WidgetStateProperty.all(Colors.black),
        ),
      ),
      menuBarTheme: MenuBarThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(bg1),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: kRadiusMd),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),
      extensions: [NxSemanticColors(textLow: textLow)],
    );
  }
}

import 'package:flutter/material.dart';

///
/// Generated from Material Theme Builder
/// https://m3.material.io/theme-builder#/dynamic
///
/// Extended with custom macro nutrient colors and gradient definitions
///

// ============================================================================
// MACRO NUTRIENT COLORS
// ============================================================================

/// Protein color - Blue
const Color colorProtein = Color(0xFF4A90E2);

/// Carbohydrates color - Orange
const Color colorCarbs = Color(0xFFF5A623);

/// Fat color - Amber
const Color colorFat = Color(0xFFFFC107);

// ============================================================================
// SEMANTIC COLORS
// ============================================================================

/// Success state color - Green
const Color colorSuccess = Color(0xFF4CAF50);

/// Warning state color - Orange
const Color colorWarning = Color(0xFFFF9800);

/// Error state color - Muted Red
const Color colorError = Color(0xFFF44336);

/// Info state color - Blue
const Color colorInfo = Color(0xFF2196F3);

// ============================================================================
// GRADIENT COLORS
// ============================================================================

/// Calorie ring gradient: green (normal) → yellow (approaching) → red (over)
const List<Color> gradientCalorieRing = [
  Color(0xFF4CAF50), // Green
  Color(0xFFFFC107), // Amber
  Color(0xFFF44336), // Red
];

/// Primary accent gradient
const List<Color> gradientPrimary = [
  Color(0xFF00897B), // Dark teal
  Color(0xFF26C6DA), // Light cyan
];

/// Success gradient
const List<Color> gradientSuccess = [
  Color(0xFF4CAF50), // Green
  Color(0xFF81C784), // Light green
];

// ============================================================================
// SHADOW UTILITIES
// ============================================================================

/// Colored shadow for elevation (primary color with opacity)
BoxShadow shadowPrimary(double elevation) {
  final opacity = switch (elevation) {
    0.0 => 0.0,
    2.0 => 0.12,
    4.0 => 0.15,
    8.0 => 0.20,
    12.0 => 0.25,
    _ => 0.15,
  };

  return BoxShadow(
    color: const Color(0xFF006E2B).withValues(alpha: opacity),
    blurRadius: elevation * 2,
    offset: Offset(0, elevation),
  );
}

/// Neutral shadow for elevation
BoxShadow shadowNeutral(double elevation) {
  final opacity = switch (elevation) {
    0.0 => 0.0,
    2.0 => 0.12,
    4.0 => 0.15,
    8.0 => 0.20,
    12.0 => 0.25,
    _ => 0.15,
  };

  return BoxShadow(
    color: Colors.black.withValues(alpha: opacity),
    blurRadius: elevation * 2,
    offset: Offset(0, elevation),
  );
}

// ============================================================================
// LIGHT COLOR SCHEME
// ============================================================================

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006E2B),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF69FF89),
  onPrimaryContainer: Color(0xFF002108),
  secondary: Color(0xFF516351),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD4E8D1),
  onSecondaryContainer: Color(0xFF0F1F11),
  tertiary: Color(0xFF39656C),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBDEAF3),
  onTertiaryContainer: Color(0xFF001F24),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFCFDF7),
  onSurface: Color(0xFF1A1C19),
  surfaceContainerHighest: Color(0xFFDDE5D9),
  onSurfaceVariant: Color(0xFF424940),
  outline: Color(0xFF727970),
  onInverseSurface: Color(0xFFF0F1EB),
  inverseSurface: Color(0xFF2E312D),
  inversePrimary: Color(0xFF33E36A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006E2B),
  outlineVariant: Color(0xFFC1C9BE),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF33E36A),
  onPrimary: Color(0xFF003913),
  primaryContainer: Color(0xFF00531F),
  onPrimaryContainer: Color(0xFF69FF89),
  secondary: Color(0xFFB8CCB5),
  onSecondary: Color(0xFF243425),
  secondaryContainer: Color(0xFF3A4B3A),
  onSecondaryContainer: Color(0xFFD4E8D1),
  tertiary: Color(0xFFA1CED6),
  onTertiary: Color(0xFF00363D),
  tertiaryContainer: Color(0xFF1F4D54),
  onTertiaryContainer: Color(0xFFBDEAF3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF1A1C19),
  onSurface: Color(0xFFE2E3DD),
  surfaceContainerHighest: Color(0xFF424940),
  onSurfaceVariant: Color(0xFFC1C9BE),
  outline: Color(0xFF8B9389),
  onInverseSurface: Color(0xFF1A1C19),
  inverseSurface: Color(0xFFE2E3DD),
  inversePrimary: Color(0xFF006E2B),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF33E36A),
  outlineVariant: Color(0xFF424940),
  scrim: Color(0xFF000000),
);

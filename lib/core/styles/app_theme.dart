import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'design_tokens.dart';

/// App Theme Factory
///
/// Centralized theme configuration for OpenNutriTracker
/// Provides light and dark theme factories with Material Design 3 support

class AppTheme {
  /// Private constructor - prevent instantiation
  AppTheme._();

  // ============================================================================
  // THEME FACTORIES
  // ============================================================================

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      brightness: Brightness.light,

      // ========================================================================
      // TYPOGRAPHY
      // ========================================================================
      textTheme: _buildTextTheme(lightColorScheme.onSurface),
      fontFamily: 'Poppins',

      // ========================================================================
      // APP BAR
      // ========================================================================
      appBarTheme: AppBarTheme(
        elevation: ONTDesignTokens.elevationLow,
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        scrolledUnderElevation: ONTDesignTokens.elevationMedium,
      ),

      // ========================================================================
      // CARDS & SURFACES
      // ========================================================================
      cardTheme: CardThemeData(
        elevation: ONTDesignTokens.elevationCard,
        color: lightColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
        ),
      ),

      // ========================================================================
      // BUTTONS
      // ========================================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: ONTDesignTokens.elevationMedium,
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing16,
            vertical: ONTDesignTokens.spacing8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusSmall),
          ),
        ),
      ),

      // ========================================================================
      // FLOATING ACTION BUTTON
      // ========================================================================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: ONTDesignTokens.elevationHigh,
        sizeConstraints: const BoxConstraints.tightFor(
          width: ONTDesignTokens.fabSize,
          height: ONTDesignTokens.fabSize,
        ),
        shape: const CircleBorder(),
      ),

      // ========================================================================
      // INPUT FIELDS
      // ========================================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColorScheme.surfaceContainer,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ONTDesignTokens.spacing16,
          vertical: ONTDesignTokens.spacing12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: lightColorScheme.outline,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: lightColorScheme.outline,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: lightColorScheme.primary,
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(
          color: lightColorScheme.onSurfaceVariant,
          fontSize: ONTDesignTokens.fontSizeBodyMedium,
        ),
      ),

      // ========================================================================
      // DIALOGS
      // ========================================================================
      dialogTheme: DialogThemeData(
        backgroundColor: lightColorScheme.surface,
        elevation: ONTDesignTokens.elevationExtra,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusXLarge),
        ),
      ),

      // ========================================================================
      // BOTTOM SHEET
      // ========================================================================
      bottomSheetTheme: BottomSheetThemeData(
        elevation: ONTDesignTokens.elevationHigh,
        backgroundColor: lightColorScheme.surface,
        modalBarrierColor: Colors.black.withValues(alpha: 0.32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ONTDesignTokens.radiusXLarge),
            topRight: Radius.circular(ONTDesignTokens.radiusXLarge),
          ),
        ),
      ),

      // ========================================================================
      // CHIPS & TABS
      // ========================================================================
      chipTheme: ChipThemeData(
        padding: EdgeInsets.symmetric(
          horizontal: ONTDesignTokens.spacing12,
          vertical: ONTDesignTokens.spacing8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusCompact),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelStyle: TextStyle(
          fontSize: ONTDesignTokens.fontSizeTitleSmall,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: ONTDesignTokens.fontSizeTitleSmall,
          fontWeight: FontWeight.w500,
        ),
        labelColor: lightColorScheme.primary,
        unselectedLabelColor: lightColorScheme.onSurfaceVariant,
      ),

      // ========================================================================
      // SNACKBAR
      // ========================================================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: lightColorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: lightColorScheme.onInverseSurface,
          fontSize: ONTDesignTokens.fontSizeBodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusSmall),
        ),
      ),

      // ========================================================================
      // DIVIDER
      // ========================================================================
      dividerTheme: DividerThemeData(
        color: lightColorScheme.outlineVariant,
        thickness: 1.0,
        space: ONTDesignTokens.spacing16,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,

      // ========================================================================
      // TYPOGRAPHY
      // ========================================================================
      textTheme: _buildTextTheme(darkColorScheme.onSurface),
      fontFamily: 'Poppins',

      // ========================================================================
      // APP BAR
      // ========================================================================
      appBarTheme: AppBarTheme(
        elevation: ONTDesignTokens.elevationLow,
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        scrolledUnderElevation: ONTDesignTokens.elevationMedium,
      ),

      // ========================================================================
      // CARDS & SURFACES
      // ========================================================================
      cardTheme: CardThemeData(
        elevation: ONTDesignTokens.elevationCard,
        color: darkColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
        ),
      ),

      // ========================================================================
      // BUTTONS
      // ========================================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: ONTDesignTokens.elevationMedium,
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing24,
            vertical: ONTDesignTokens.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ONTDesignTokens.spacing16,
            vertical: ONTDesignTokens.spacing8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ONTDesignTokens.radiusSmall),
          ),
        ),
      ),

      // ========================================================================
      // FLOATING ACTION BUTTON
      // ========================================================================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: ONTDesignTokens.elevationHigh,
        sizeConstraints: const BoxConstraints.tightFor(
          width: ONTDesignTokens.fabSize,
          height: ONTDesignTokens.fabSize,
        ),
        shape: const CircleBorder(),
      ),

      // ========================================================================
      // INPUT FIELDS
      // ========================================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.surfaceContainer,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ONTDesignTokens.spacing16,
          vertical: ONTDesignTokens.spacing12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: darkColorScheme.outline,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: darkColorScheme.outline,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusMedium),
          borderSide: BorderSide(
            color: darkColorScheme.primary,
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(
          color: darkColorScheme.onSurfaceVariant,
          fontSize: ONTDesignTokens.fontSizeBodyMedium,
        ),
      ),

      // ========================================================================
      // DIALOGS
      // ========================================================================
      dialogTheme: DialogThemeData(
        backgroundColor: darkColorScheme.surface,
        elevation: ONTDesignTokens.elevationExtra,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusXLarge),
        ),
      ),

      // ========================================================================
      // BOTTOM SHEET
      // ========================================================================
      bottomSheetTheme: BottomSheetThemeData(
        elevation: ONTDesignTokens.elevationHigh,
        backgroundColor: darkColorScheme.surface,
        modalBarrierColor: Colors.black.withValues(alpha: 0.32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ONTDesignTokens.radiusXLarge),
            topRight: Radius.circular(ONTDesignTokens.radiusXLarge),
          ),
        ),
      ),

      // ========================================================================
      // CHIPS & TABS
      // ========================================================================
      chipTheme: ChipThemeData(
        padding: EdgeInsets.symmetric(
          horizontal: ONTDesignTokens.spacing12,
          vertical: ONTDesignTokens.spacing8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusCompact),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelStyle: TextStyle(
          fontSize: ONTDesignTokens.fontSizeTitleSmall,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: ONTDesignTokens.fontSizeTitleSmall,
          fontWeight: FontWeight.w500,
        ),
        labelColor: darkColorScheme.primary,
        unselectedLabelColor: darkColorScheme.onSurfaceVariant,
      ),

      // ========================================================================
      // SNACKBAR
      // ========================================================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkColorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: darkColorScheme.onInverseSurface,
          fontSize: ONTDesignTokens.fontSizeBodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ONTDesignTokens.radiusSmall),
        ),
      ),

      // ========================================================================
      // DIVIDER
      // ========================================================================
      dividerTheme: DividerThemeData(
        color: darkColorScheme.outlineVariant,
        thickness: 1.0,
        space: ONTDesignTokens.spacing16,
      ),
    );
  }

  // ============================================================================
  // PRIVATE HELPERS
  // ============================================================================

  /// Build custom TextTheme with Poppins font and proper weights
  static TextTheme _buildTextTheme(Color defaultColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: ONTDesignTokens.fontSizeDisplayLarge,
        fontWeight: FontWeight.w700, // Bold
        letterSpacing: -0.4,
        height: 1.2,
        color: defaultColor,
      ),
      displayMedium: TextStyle(
        fontSize: ONTDesignTokens.fontSizeDisplayMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.2,
        color: defaultColor,
      ),
      displaySmall: TextStyle(
        fontSize: ONTDesignTokens.fontSizeDisplaySmall,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.3,
        color: defaultColor,
      ),
      headlineLarge: TextStyle(
        fontSize: ONTDesignTokens.fontSizeHeadlineLarge,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.3,
        color: defaultColor,
      ),
      headlineMedium: TextStyle(
        fontSize: ONTDesignTokens.fontSizeHeadlineMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.4,
        color: defaultColor,
      ),
      headlineSmall: TextStyle(
        fontSize: ONTDesignTokens.fontSizeHeadlineSmall,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.4,
        color: defaultColor,
      ),
      titleLarge: TextStyle(
        fontSize: ONTDesignTokens.fontSizeTitleLarge,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0.15,
        height: 1.4,
        color: defaultColor,
      ),
      titleMedium: TextStyle(
        fontSize: ONTDesignTokens.fontSizeTitleMedium,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        color: defaultColor,
      ),
      titleSmall: TextStyle(
        fontSize: ONTDesignTokens.fontSizeTitleSmall,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.5,
        color: defaultColor,
      ),
      bodyLarge: TextStyle(
        fontSize: ONTDesignTokens.fontSizeBodyLarge,
        fontWeight: FontWeight.w400, // Regular
        letterSpacing: 0.5,
        height: 1.5,
        color: defaultColor,
      ),
      bodyMedium: TextStyle(
        fontSize: ONTDesignTokens.fontSizeBodyMedium,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
        color: defaultColor,
      ),
      bodySmall: TextStyle(
        fontSize: ONTDesignTokens.fontSizeBodySmall,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
        color: defaultColor,
      ),
      labelLarge: TextStyle(
        fontSize: ONTDesignTokens.fontSizeLabelLarge,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0.1,
        height: 1.4,
        color: defaultColor,
      ),
      labelMedium: TextStyle(
        fontSize: ONTDesignTokens.fontSizeLabelMedium,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.3,
        color: defaultColor,
      ),
      labelSmall: TextStyle(
        fontSize: ONTDesignTokens.fontSizeLabelSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.3,
        color: defaultColor,
      ),
    );
  }
}

// ============================================================================
// THEME EXTENSION METHODS
// ============================================================================

/// Extensions for easier theme access
extension ThemeExtensions on BuildContext {
  /// Get current ColorScheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Get current TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get current brightness
  Brightness get brightness => Theme.of(this).brightness;

  /// Check if dark mode is enabled
  bool get isDarkMode => brightness == Brightness.dark;

  /// Check if light mode is enabled
  bool get isLightMode => brightness == Brightness.light;
}

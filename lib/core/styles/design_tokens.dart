import 'package:flutter/material.dart';

/// Design Tokens for OpenNutriTracker
///
/// This file contains all design system tokens (spacing, radius, elevation, animations)
/// used throughout the app. These tokens ensure visual consistency and make it easy
/// to maintain and update the design system.
///
/// ## Usage Guidelines:
/// - Always use tokens instead of hardcoded values
/// - Tokens follow Material Design 3 principles
/// - Values are based on an 8dp baseline grid
///
/// ## Token Categories:
/// 1. Spacing - Consistent margins and padding
/// 2. Border Radius - Rounded corner consistency
/// 3. Elevation - Depth and shadow system
/// 4. Animations - Motion and timing
/// 5. Colors - Macro nutrients and semantic colors

class ONTDesignTokens {
  // ============================================================================
  // SPACING TOKENS
  // ============================================================================
  /// Spacing scale based on 8dp baseline grid
  /// Use for margins, padding, and layout spacing

  static const double spacing4 = 4.0;    // Extra small
  static const double spacing8 = 8.0;    // Small
  static const double spacing12 = 12.0;  // Small-Medium
  static const double spacing16 = 16.0;  // Medium (standard)
  static const double spacing24 = 24.0;  // Medium-Large
  static const double spacing32 = 32.0;  // Large
  static const double spacing48 = 48.0;  // Extra Large

  /// Semantic spacing names (easier to remember than numbers)
  static const double spacingXSmall = spacing4;
  static const double spacingSmall = spacing8;
  static const double spacingMedium = spacing16;
  static const double spacingLarge = spacing24;
  static const double spacingXLarge = spacing32;
  static const double spacingXXLarge = spacing48;

  // ============================================================================
  // BORDER RADIUS TOKENS
  // ============================================================================
  /// Border radius scale for rounded corners
  /// Follows Material Design 3 specifications

  static const double radiusSmall = 8.0;    // Small elements (chips, badges)
  static const double radiusMedium = 12.0;  // Medium elements (buttons)
  static const double radiusLarge = 16.0;   // Large elements (cards)
  static const double radiusXLarge = 24.0;  // Extra large (bottom sheets, dialogs)

  /// Semantic radius names
  static const double radiusCompact = radiusSmall;      // Compact components
  static const double radiusDefault = radiusLarge;      // Default cards
  static const double radiusExpanded = radiusXLarge;    // Expanded components

  // ============================================================================
  // ELEVATION & SHADOW TOKENS
  // ============================================================================
  /// Elevation scale for depth perception
  /// Each elevation level has corresponding shadow definition

  static const double elevationNone = 0.0;      // No shadow (flat elements)
  static const double elevationLow = 2.0;       // Subtle depth
  static const double elevationMedium = 4.0;    // Interactive elements
  static const double elevationHigh = 8.0;      // Floating elements, FABs
  static const double elevationExtra = 12.0;    // Modals, dialogs

  /// Semantic elevation names
  static const double elevationCard = elevationLow;
  static const double elevationInteractive = elevationMedium;
  static const double elevationFloating = elevationHigh;

  // ============================================================================
  // ANIMATION TIMING TOKENS
  // ============================================================================
  /// Animation durations for consistent motion
  /// Use Curves.easeInOut or custom curves for smooth animations

  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  /// Semantic animation names
  static const Duration animationQuick = animationFast;
  static const Duration animationStandard = animationNormal;
  static const Duration animationDelightful = animationSlow;

  // ============================================================================
  // ANIMATION CURVE TOKENS
  // ============================================================================
  /// Standard curves used throughout the app
  /// Follow Material Design motion principles

  static Curve get curveStandard => Curves.easeInOut;
  static Curve get curveAccelerate => Curves.easeOut;
  static Curve get curveDecelerate => Curves.easeIn;
  static Curve get curveSharp => Curves.easeInOutCubic;
  static Curve get curveSpring => Curves.elasticOut;
  static Curve get curveBounce => Curves.bounceOut;

  // ============================================================================
  // COLOR TOKENS - MACRO NUTRIENTS
  // ============================================================================
  /// Macro nutrient colors for data visualization
  /// Color-coded to help users distinguish between nutrition types

  static const int colorProtein = 0xFF4A90E2;    // Blue - Protein
  static const int colorCarbs = 0xFFF5A623;      // Orange - Carbohydrates
  static const int colorFat = 0xFFFFC107;        // Amber - Fat

  /// Semantic color names
  static const int colorMacroProtein = colorProtein;
  static const int colorMacroCarbs = colorCarbs;
  static const int colorMacroFat = colorFat;

  // ============================================================================
  // COLOR TOKENS - SEMANTIC
  // ============================================================================
  /// Semantic colors for various UI states

  static const int colorSuccess = 0xFF4CAF50;    // Green
  static const int colorWarning = 0xFFFF9800;    // Orange
  static const int colorError = 0xFFF44336;      // Red (muted)
  static const int colorInfo = 0xFF2196F3;       // Blue

  // ============================================================================
  // GRADIENT DEFINITIONS
  // ============================================================================
  /// Predefined gradients for enhanced visual polish
  /// Use for buttons, cards, and progress indicators

  /// Calorie ring gradient: green (normal) → yellow (approaching limit) → red (over limit)
  static final List<int> gradientCalorieRing = [
    0xFF4CAF50,  // Green
    0xFFFFC107,  // Amber
    0xFFF44336,  // Red
  ];

  /// Primary accent gradient
  static final List<int> gradientPrimary = [
    0xFF00897B,  // Dark teal
    0xFF26C6DA,  // Light cyan
  ];

  /// Success gradient
  static final List<int> gradientSuccess = [
    0xFF4CAF50,  // Green
    0xFF81C784,  // Light green
  ];

  // ============================================================================
  // TYPOGRAPHY TOKENS
  // ============================================================================
  /// Font size and weight tokens for text hierarchy
  /// Paired with TextTheme defined in app_theme.dart

  static const double fontSizeDisplayLarge = 57.0;
  static const double fontSizeDisplayMedium = 45.0;
  static const double fontSizeDisplaySmall = 36.0;
  static const double fontSizeHeadlineLarge = 32.0;
  static const double fontSizeHeadlineMedium = 28.0;
  static const double fontSizeHeadlineSmall = 24.0;
  static const double fontSizeTitleLarge = 22.0;
  static const double fontSizeTitleMedium = 16.0;
  static const double fontSizeTitleSmall = 14.0;
  static const double fontSizeBodyLarge = 16.0;
  static const double fontSizeBodyMedium = 14.0;
  static const double fontSizeBodySmall = 12.0;
  static const double fontSizeLabelLarge = 14.0;
  static const double fontSizeLabelMedium = 12.0;
  static const double fontSizeLabelSmall = 11.0;

  // ============================================================================
  // ICON SIZE TOKENS
  // ============================================================================
  /// Standardized icon sizes for consistency

  static const double iconSizeSmall = 16.0;
  static const double iconSizeSmallMedium = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeMediumLarge = 32.0;
  static const double iconSizeLarge = 48.0;
  static const double iconSizeXLarge = 64.0;

  // ============================================================================
  // TOUCH TARGET SIZE TOKENS
  // ============================================================================
  /// Minimum touch target sizes following Material Design guidelines
  /// Ensure accessibility and easy interaction

  static const double touchTargetSmall = 40.0;      // Minimum for secondary targets
  static const double touchTargetDefault = 48.0;    // Standard (Material Design)
  static const double touchTargetLarge = 56.0;      // For primary actions

  // ============================================================================
  // COMPONENT SIZE TOKENS
  // ============================================================================
  /// Common component dimensions

  static const double fabSize = 56.0;            // Floating Action Button
  static const double fabSizeExtended = 56.0;    // Extended FAB (height)
  static const double appBarHeight = 56.0;       // Standard app bar
  static const double buttonHeight = 40.0;       // Standard button
  static const double chipHeight = 32.0;         // Chip component

  // ============================================================================
  // SHADOW DEFINITIONS
  // ============================================================================
  /// Shadow configurations for depth perception
  /// Use with Elevation tokens

  /// Low elevation shadow (2dp)
  static const double shadowBlurRadiusLow = 3.0;
  static const double shadowSpreadRadiusLow = 0.0;
  static const double shadowOffsetXLow = 0.0;
  static const double shadowOffsetYLow = 2.0;
  static const double shadowOpacityLow = 0.12;

  /// Medium elevation shadow (4dp)
  static const double shadowBlurRadiusMedium = 8.0;
  static const double shadowSpreadRadiusMedium = 0.0;
  static const double shadowOffsetXMedium = 0.0;
  static const double shadowOffsetYMedium = 4.0;
  static const double shadowOpacityMedium = 0.15;

  /// High elevation shadow (8dp)
  static const double shadowBlurRadiusHigh = 16.0;
  static const double shadowSpreadRadiusHigh = 0.0;
  static const double shadowOffsetXHigh = 0.0;
  static const double shadowOffsetYHigh = 8.0;
  static const double shadowOpacityHigh = 0.20;

  // ============================================================================
  // Z-INDEX / STACKING CONTEXT
  // ============================================================================
  /// Stacking order for overlapping elements

  static const int zIndexBackground = 0;
  static const int zIndexDefault = 1;
  static const int zIndexAppBar = 10;
  static const int zIndexFloating = 20;
  static const int zIndexModal = 100;
  static const int zIndexSnackbar = 110;
  static const int zIndexTooltip = 120;

  // ============================================================================
  // OPACITY TOKENS
  // ============================================================================
  /// Standard opacity values for transparency effects

  static const double opacityDisabled = 0.38;
  static const double opacityHover = 0.08;
  static const double opacityFocus = 0.12;
  static const double opacityPressed = 0.12;
  static const double opacityDrag = 0.16;
  static const double opacityShadow = 0.20;
}

// ============================================================================
// USAGE GUIDE
// ============================================================================
///
/// ## How to Use Design Tokens
///
/// ### Spacing Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(ONTDesignTokens.spacing16),
///   child: Text('Hello'),
/// )
/// ```
///
/// ### Border Radius Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
///   ),
/// )
/// ```
///
/// ### Elevation Example:
/// ```dart
/// Card(
///   elevation: ONTDesignTokens.elevationCard,
/// )
/// ```
///
/// ### Animation Example:
/// ```dart
/// AnimatedContainer(
///   duration: ONTDesignTokens.animationNormal,
///   curve: ONTDesignTokens.curveStandard,
///   color: Colors.blue,
/// )
/// ```
///
/// ### Color Example (Macros):
/// ```dart
/// CircleAvatar(
///   backgroundColor: Color(ONTDesignTokens.colorProtein),
///   child: Text('P'),
/// )
/// ```

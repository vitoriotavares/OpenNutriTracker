import 'package:flutter/material.dart';

const String fontFamily = 'Poppins';

/// Enhanced Typography System
/// Uses design tokens for consistency and maintainability
/// Hierarchy: Display > Headline > Title > Body > Label

/// Standard app text theme with Poppins font
var appTextTheme = const TextTheme(
  // ============================================================================
  // DISPLAY STYLES (Hero Numbers, Large Titles)
  // ============================================================================
  displayLarge: TextStyle(
    fontFamily: fontFamily,
    fontSize: 57.0,
    fontWeight: FontWeight.w700, // Bold - for hero numbers (calories)
    letterSpacing: -0.4,
    height: 1.2,
  ),
  displayMedium: TextStyle(
    fontFamily: fontFamily,
    fontSize: 45.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.2,
  ),
  displaySmall: TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.3,
  ),

  // ============================================================================
  // HEADLINE STYLES (Section Headers)
  // ============================================================================
  headlineLarge: TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w700, // Bold
    letterSpacing: 0.0,
    height: 1.3,
  ),
  headlineMedium: TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.4,
  ),
  headlineSmall: TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.4,
  ),

  // ============================================================================
  // TITLE STYLES (Card Headers, Subsection Titles)
  // ============================================================================
  titleLarge: TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.0,
    fontWeight: FontWeight.w600, // SemiBold
    letterSpacing: 0.15,
    height: 1.4,
  ),
  titleMedium: TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  ),
  titleSmall: TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.5,
  ),

  // ============================================================================
  // BODY STYLES (Main Content, Descriptions)
  // ============================================================================
  bodyLarge: TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.5,
    height: 1.5,
  ),
  bodyMedium: TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodySmall: TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.5,
  ),

  // ============================================================================
  // LABEL STYLES (Small UI Text, Badges, Chips)
  // ============================================================================
  labelLarge: TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.1,
    height: 1.4,
  ),
  labelMedium: TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
  ),
  labelSmall: TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
  ),
);

// ============================================================================
// CUSTOM TEXT STYLES
// ============================================================================

/// Hero calorie number style - Large, bold, prominent
const TextStyle heroNumberStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 64.0,
  fontWeight: FontWeight.w700,
  letterSpacing: -0.5,
  height: 1.0,
);

/// Macro nutrient label style - For protein/carbs/fat labels
const TextStyle macroLabelStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
);

/// Macro value style - For macro numbers
const TextStyle macroValueStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.0,
);

/// Daily goal text style - Subtle, secondary
const TextStyle dailyGoalStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 13.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);

/// Card header style - For meal/activity card titles
const TextStyle cardHeaderStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.0,
);

/// Card content style - For meal/activity card descriptions
const TextStyle cardContentStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

/// Badge/Chip style - Small, emphasized text
const TextStyle badgeStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 11.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.4,
);

/// Button text style - Action items
const TextStyle buttonTextStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
);

/// Hint/helper text style - Secondary information
const TextStyle hintTextStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 13.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

// ============================================================================
// TYPOGRAPHY DOCUMENTATION
// ============================================================================

/// Typography Hierarchy Guide:
///
/// Display Styles (57-36sp, Bold)
/// └─ Hero numbers (calorie count)
/// └─ Large title sections
///
/// Headline Styles (32-24sp, Bold)
/// └─ Page titles
/// └─ Section headers
///
/// Title Styles (22-14sp, SemiBold)
/// └─ Card headers
/// └─ Subsection titles
///
/// Body Styles (16-12sp, Regular)
/// └─ Main content text
/// └─ Descriptions
/// └─ Form inputs
///
/// Label Styles (14-11sp, Medium)
/// └─ Small UI text
/// └─ Badges
/// └─ Chips
/// └─ Helper text
///
/// Usage Examples:
/// ```dart
/// // Hero number
/// Text('2450', style: appTextTheme.displayLarge)
///
/// // Card title
/// Text('Breakfast', style: appTextTheme.titleLarge)
///
/// // Body text
/// Text('Chicken breast with vegetables', style: appTextTheme.bodyMedium)
///
/// // Helper text
/// Text('Estimated values', style: appTextTheme.labelSmall)
/// ```

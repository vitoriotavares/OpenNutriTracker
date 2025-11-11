import 'dart:ui';

import 'package:flutter/material.dart';

import '../../styles/design_tokens.dart';

/// Modern Card Component
///
/// A versatile card widget with multiple design variants to provide
/// visual hierarchy and consistency throughout the app.
///
/// Features:
/// - Dynamic elevation levels
/// - Colored shadows with customizable opacity
/// - Support for gradient overlays
/// - Glassmorphism variant with blur effect
/// - Animated interactions on tap
/// - Responsive padding and border radius
/// - Dark mode support

class ModernCard extends StatefulWidget {
  /// Card content
  final Widget child;

  /// Background color (uses theme surface by default)
  final Color? backgroundColor;

  /// Elevation level (0-4)
  final double elevation;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Gradient overlay (optional)
  final Gradient? gradient;

  /// Shadow color (if null, uses intelligent color based on elevation)
  final Color? shadowColor;

  /// Card variant
  final ModernCardVariant variant;

  /// Enable glassmorphism effect
  final bool enableGlassmorphism;

  /// Glassmorphism blur sigma
  final double glassmorphismBlur;

  /// Padding inside the card
  final EdgeInsets? padding;

  /// Margin around the card
  final EdgeInsets? margin;

  /// Callback on tap
  final VoidCallback? onTap;

  /// Enable tap scale animation
  final bool enableTapAnimation;

  /// Border decoration
  final Border? border;

  /// Custom elevation shadow
  final List<BoxShadow>? customShadows;

  const ModernCard({
    required this.child,
    this.backgroundColor,
    this.elevation = ONTDesignTokens.elevationCard,
    this.borderRadius,
    this.gradient,
    this.shadowColor,
    this.variant = ModernCardVariant.standard,
    this.enableGlassmorphism = false,
    this.glassmorphismBlur = 10,
    this.padding,
    this.margin,
    this.onTap,
    this.enableTapAnimation = true,
    this.border,
    this.customShadows,
    super.key,
  });

  @override
  State<ModernCard> createState() => _ModernCardState();
}

enum ModernCardVariant {
  /// Standard elevated card
  standard,

  /// Outlined card with border
  outlined,

  /// Flat card with minimal elevation
  flat,

  /// Filled card with background color
  filled,

  /// Gradient card with gradient overlay
  gradient,

  /// Glassmorphism card with blur effect
  glassmorphism,
}

class _ModernCardState extends State<ModernCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.enableTapAnimation && widget.onTap != null) {
      _tapController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enableTapAnimation && widget.onTap != null) {
      _tapController.reverse();
      widget.onTap?.call();
    }
  }

  void _onTapCancel() {
    if (widget.enableTapAnimation && widget.onTap != null) {
      _tapController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine background color based on variant
    Color backgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.surface;

    if (widget.variant == ModernCardVariant.filled) {
      backgroundColor = widget.backgroundColor ??
          Theme.of(context).colorScheme.surfaceContainer;
    }

    // Border radius
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(ONTDesignTokens.radiusLarge);

    // Build shadows
    List<BoxShadow> shadows = widget.customShadows ?? [];
    if (shadows.isEmpty && widget.variant != ModernCardVariant.flat) {
      shadows = _buildShadows(context);
    }

    Widget cardChild = widget.child;

    // Apply gradient overlay if gradient variant
    if (widget.variant == ModernCardVariant.gradient ||
        widget.gradient != null) {
      cardChild = Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: widget.gradient ??
                      LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.05),
                        ],
                      ),
                  borderRadius: borderRadius,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Apply glassmorphism if enabled
    if (widget.enableGlassmorphism ||
        widget.variant == ModernCardVariant.glassmorphism) {
      cardChild = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.glassmorphismBlur,
            sigmaY: widget.glassmorphismBlur,
          ),
          child: cardChild,
        ),
      );
    }

    // Build the card decoration
    final decoration = BoxDecoration(
      color: widget.variant == ModernCardVariant.glassmorphism
          ? backgroundColor.withValues(alpha: 0.7)
          : backgroundColor,
      borderRadius: borderRadius,
      border: widget.variant == ModernCardVariant.outlined
          ? widget.border ??
          Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          )
          : widget.border,
      boxShadow: shadows,
    );

    // Main card widget
    Widget card = Container(
      decoration: decoration,
      padding: widget.padding,
      child: cardChild,
    );

    // Apply scale animation if enabled
    if (widget.enableTapAnimation && widget.onTap != null) {
      card = ScaleTransition(
        scale: _scaleAnimation,
        child: card,
      );
    }

    // Wrap with tap handlers
    if (widget.onTap != null) {
      card = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: card,
      );
    }

    // Apply margin
    if (widget.margin != null) {
      card = Padding(
        padding: widget.margin!,
        child: card,
      );
    }

    return card;
  }

  List<BoxShadow> _buildShadows(BuildContext context) {
    final elevation = widget.elevation;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Determine shadow color (intelligent based on elevation and mode)
    Color shadowColor = widget.shadowColor ??
        (isDarkMode
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.1));

    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
        spreadRadius: elevation * 0.5,
      ),
      if (elevation > 2)
        BoxShadow(
          color: shadowColor.withValues(alpha: shadowColor.a * 0.5),
          blurRadius: elevation * 4,
          offset: Offset(0, elevation * 2),
          spreadRadius: 0,
        ),
    ];
  }
}

/// Simplified modern card with preset configurations
class ElevatedModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const ElevatedModernCard({
    required this.child,
    this.padding = const EdgeInsets.all(ONTDesignTokens.spacing16),
    this.margin,
    this.onTap,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      elevation: ONTDesignTokens.elevationCard,
      padding: padding,
      margin: margin,
      onTap: onTap,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}

/// Outlined modern card variant
class OutlinedModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? borderColor;

  const OutlinedModernCard({
    required this.child,
    this.padding = const EdgeInsets.all(ONTDesignTokens.spacing16),
    this.margin,
    this.onTap,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      variant: ModernCardVariant.outlined,
      padding: padding,
      margin: margin,
      onTap: onTap,
      border: Border.all(
        color: borderColor ?? Theme.of(context).colorScheme.outline,
        width: 1,
      ),
      child: child,
    );
  }
}

/// Flat modern card with minimal elevation
class FlatModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const FlatModernCard({
    required this.child,
    this.padding = const EdgeInsets.all(ONTDesignTokens.spacing16),
    this.margin,
    this.onTap,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      elevation: ONTDesignTokens.elevationNone,
      padding: padding,
      margin: margin,
      onTap: onTap,
      backgroundColor: backgroundColor,
      variant: ModernCardVariant.flat,
      enableTapAnimation: false,
      child: child,
    );
  }
}

/// Gradient modern card variant
class GradientModernCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const GradientModernCard({
    required this.child,
    required this.gradient,
    this.padding = const EdgeInsets.all(ONTDesignTokens.spacing16),
    this.margin,
    this.onTap,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      elevation: ONTDesignTokens.elevationCard,
      padding: padding,
      margin: margin,
      onTap: onTap,
      gradient: gradient,
      backgroundColor: backgroundColor,
      variant: ModernCardVariant.gradient,
      child: child,
    );
  }
}

/// Glassmorphism modern card variant
class GlassmorphismModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final double blurSigma;
  final Color? backgroundColor;

  const GlassmorphismModernCard({
    required this.child,
    this.padding = const EdgeInsets.all(ONTDesignTokens.spacing16),
    this.margin,
    this.onTap,
    this.blurSigma = 10,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      elevation: ONTDesignTokens.elevationCard,
      padding: padding,
      margin: margin,
      onTap: onTap,
      enableGlassmorphism: true,
      glassmorphismBlur: blurSigma,
      backgroundColor: backgroundColor,
      variant: ModernCardVariant.glassmorphism,
      child: child,
    );
  }
}

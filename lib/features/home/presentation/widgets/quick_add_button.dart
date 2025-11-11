import 'package:flutter/material.dart';

import '../../../../core/styles/design_tokens.dart';
import '../../../../core/utils/micro_interactions.dart';

/// Quick Add Button for Meal Sections
///
/// A compact button that allows users to quickly add meals to a specific
/// meal type (breakfast, lunch, dinner, snack). Displayed at the end of
/// each meal section in the home page.
///
/// Features:
/// - Animated tap feedback with scale effect
/// - Icon + text label
/// - Customizable styling and colors
/// - Haptic feedback on tap

class QuickAddButton extends StatefulWidget {
  /// Label for the button (e.g., "Breakfast", "Lunch")
  final String label;

  /// Icon to display
  final IconData icon;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Background color
  final Color? backgroundColor;

  /// Foreground/text color
  final Color? foregroundColor;

  /// Icon size
  final double iconSize;

  /// Show with outlined style instead of filled
  final bool outlined;

  const QuickAddButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.iconSize = ONTDesignTokens.iconSizeMedium,
    this.outlined = false,
    super.key,
  });

  @override
  State<QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<QuickAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: widget.outlined
            ? _buildOutlinedButton(context)
            : _buildFilledButton(context),
      ),
    );
  }

  Widget _buildFilledButton(BuildContext context) {
    final backgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.primary;
    final foregroundColor = widget.foregroundColor ??
        Theme.of(context).colorScheme.onPrimary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ONTDesignTokens.spacing12,
        vertical: ONTDesignTokens.spacing8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(ONTDesignTokens.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            blurRadius: ONTDesignTokens.elevationCard * 2,
            offset: Offset(0, ONTDesignTokens.elevationCard),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulseAnimation(
            duration: const Duration(milliseconds: 2000),
            minOpacity: 0.6,
            child: Icon(
              Icons.add,
              size: widget.iconSize - 4,
              color: foregroundColor,
            ),
          ),
          SizedBox(width: ONTDesignTokens.spacing4),
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    final foregroundColor = widget.foregroundColor ??
        Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ONTDesignTokens.spacing12,
        vertical: ONTDesignTokens.spacing8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: foregroundColor,
          width: 1.5,
        ),
        borderRadius:
            BorderRadius.circular(ONTDesignTokens.radiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulseAnimation(
            duration: const Duration(milliseconds: 2000),
            minOpacity: 0.6,
            child: Icon(
              Icons.add,
              size: widget.iconSize - 4,
              color: foregroundColor,
            ),
          ),
          SizedBox(width: ONTDesignTokens.spacing4),
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Preset quick add button for meals
class QuickAddMealButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? customLabel;

  const QuickAddMealButton({
    required this.onPressed,
    this.customLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuickAddButton(
      label: customLabel ?? 'Add Meal',
      icon: Icons.add,
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}

/// Preset quick add button for activities
class QuickAddActivityButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? customLabel;

  const QuickAddActivityButton({
    required this.onPressed,
    this.customLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuickAddButton(
      label: customLabel ?? 'Add Activity',
      icon: Icons.add,
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
    );
  }
}

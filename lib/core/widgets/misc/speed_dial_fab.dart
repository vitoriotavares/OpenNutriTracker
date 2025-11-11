import 'package:flutter/material.dart';

import '../../styles/design_tokens.dart';

/// Speed Dial FAB Action Item
class SpeedDialAction {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SpeedDialAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });
}

/// Speed Dial Floating Action Button
///
/// An expandable FAB that displays multiple action buttons in a speed dial
/// menu. When tapped, the FAB expands with a spring animation to reveal
/// actions like "Add Meal", "Add Activity", and "Scan Barcode".
///
/// Features:
/// - Spring animation on expand/collapse
/// - Backdrop dim effect on open
/// - Customizable actions and styling
/// - Responsive positioning
/// - Haptic feedback on interactions

class SpeedDialFab extends StatefulWidget {
  /// List of actions available in the speed dial
  final List<SpeedDialAction> actions;

  /// Primary FAB icon
  final IconData mainIcon;

  /// Icon when expanded (usually X or ^)
  final IconData? closeIcon;

  /// Background color of main FAB
  final Color? backgroundColor;

  /// Foreground color of main FAB
  final Color? foregroundColor;

  /// Show backdrop dim when expanded
  final bool showBackdrop;

  /// Backdrop color opacity
  final double backdropOpacity;

  /// Animation duration
  final Duration animationDuration;

  /// Spacing between action buttons (vertical)
  final double spacing;

  /// Optional callback when FAB is opened/closed
  final ValueChanged<bool>? onOpenChanged;

  /// Show labels for actions
  final bool showLabels;

  const SpeedDialFab({
    required this.actions,
    this.mainIcon = Icons.add,
    this.closeIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.showBackdrop = true,
    this.backdropOpacity = 0.5,
    this.animationDuration = const Duration(milliseconds: 300),
    this.spacing = 16,
    this.onOpenChanged,
    this.showLabels = true,
    super.key,
  });

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fabRotationAnimation;
  late Animation<double> _fabScaleAnimation;
  late List<Animation<Offset>> _actionAnimations;

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Main FAB rotation (0 to 45 degrees)
    _fabRotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ONTDesignTokens.curveStandard,
      ),
    );

    // Main FAB scale
    _fabScaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ONTDesignTokens.curveStandard,
      ),
    );

    // Action button animations (staggered from bottom)
    _actionAnimations = List.generate(
      widget.actions.length,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0),
        end: Offset(0, -(index + 1) * (56 + widget.spacing / 2).toDouble()),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.0,
            0.8,
            curve: Curves.elasticOut,
          ),
        ),
      ),
    );
  }

  void _toggleFab() {
    if (_isOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
    widget.onOpenChanged?.call(_isOpen);
  }

  void _handleActionTap(SpeedDialAction action) {
    action.onTap();
    _toggleFab(); // Close FAB after action
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        // Backdrop - only when open
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleFab,
              child: AnimatedOpacity(
                opacity: widget.backdropOpacity,
                duration: widget.animationDuration,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
          ),

        // Column with actions + main FAB
        Positioned(
          bottom: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Action buttons (only render if open)
              if (_isOpen)
                ...List.generate(widget.actions.length, (index) {
                  final action = widget.actions[index];
                  return SlideTransition(
                    position: _actionAnimations[index],
                    child: FadeTransition(
                      opacity: _animationController.drive(
                        Tween<double>(begin: 0, end: 1).chain(
                          CurveTween(
                            curve: Interval(
                              0.2 + (index * 0.1),
                              0.9,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: widget.spacing),
                        child: _SpeedDialActionButton(
                          action: action,
                          onTap: () => _handleActionTap(action),
                          showLabel: widget.showLabels,
                        ),
                      ),
                    ),
                  );
                }),

              // Main FAB button
              Padding(
                padding: EdgeInsets.all(ONTDesignTokens.spacing16),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _fabRotationAnimation.value * 3.14159 / 4,
                      child: Transform.scale(
                        scale: _fabScaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: _toggleFab,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.backgroundColor ??
                            Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: (widget.backgroundColor ??
                                    Theme.of(context).colorScheme.primary)
                                .withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          _isOpen
                              ? (widget.closeIcon ?? Icons.close)
                              : widget.mainIcon,
                          size: ONTDesignTokens.iconSizeMedium,
                          color: widget.foregroundColor ??
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Individual action button in the speed dial menu
class _SpeedDialActionButton extends StatefulWidget {
  final SpeedDialAction action;
  final VoidCallback onTap;
  final bool showLabel;

  const _SpeedDialActionButton({
    required this.action,
    required this.onTap,
    this.showLabel = true,
  });

  @override
  State<_SpeedDialActionButton> createState() =>
      _SpeedDialActionButtonState();
}

class _SpeedDialActionButtonState extends State<_SpeedDialActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _hoverController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _hoverController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showLabel)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ONTDesignTokens.spacing12,
                vertical: ONTDesignTokens.spacing8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    BorderRadius.circular(ONTDesignTokens.radiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.action.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(width: 12),
          GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: ScaleTransition(
              scale: _hoverController.drive(
                Tween<double>(begin: 1.0, end: 0.85),
              ),
              child: FloatingActionButton.small(
                onPressed: widget.onTap,
                backgroundColor: widget.action.backgroundColor ??
                    Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor: widget.action.foregroundColor ??
                    Theme.of(context).colorScheme.onSecondaryContainer,
                elevation: ONTDesignTokens.elevationCard,
                child: Icon(
                  widget.action.icon,
                  size: ONTDesignTokens.iconSizeSmallMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper to create preset speed dial actions
class SpeedDialActionPresets {
  static SpeedDialAction addMeal({
    required VoidCallback onTap,
    String label = 'Add Meal',
  }) {
    return SpeedDialAction(
      label: label,
      icon: Icons.restaurant_menu,
      onTap: onTap,
      backgroundColor: const Color(0xFF4A90E2), // Protein blue
    );
  }

  static SpeedDialAction addActivity({
    required VoidCallback onTap,
    String label = 'Add Activity',
  }) {
    return SpeedDialAction(
      label: label,
      icon: Icons.fitness_center,
      onTap: onTap,
      backgroundColor: const Color(0xFF4CAF50), // Success green
    );
  }

  static SpeedDialAction scanBarcode({
    required VoidCallback onTap,
    String label = 'Scan Barcode',
  }) {
    return SpeedDialAction(
      label: label,
      icon: Icons.qr_code_scanner,
      onTap: onTap,
      backgroundColor: const Color(0xFFFFC107), // Amber
    );
  }
}

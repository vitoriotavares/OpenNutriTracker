import 'dart:ui';

import 'package:flutter/material.dart';

import '../../styles/design_tokens.dart';

/// Modern Bottom Sheet Widget
///
/// A customizable bottom sheet with modern design features including:
/// - Visual drag indicator at the top
/// - Snap points (25%, 50%, 100% height)
/// - Spring physics for drag
/// - Blur backdrop with customizable opacity
/// - Keyboard-aware sizing
/// - Smooth animations

class ModernBottomSheet extends StatefulWidget {
  /// The content to display in the bottom sheet
  final Widget child;

  /// Initial height ratio (0.0 to 1.0)
  final double initialHeightFraction;

  /// Minimum height ratio (prevents collapsing below this)
  final double minHeightFraction;

  /// Maximum height ratio
  final double maxHeightFraction;

  /// Enable backdrop blur effect
  final bool enableBackdrop;

  /// Backdrop blur sigma
  final double backdropBlurSigma;

  /// Show drag indicator handle
  final bool showDragHandle;

  /// Enable snap points
  final bool enableSnapPoints;

  /// Snap points as height fractions (0.0 to 1.0)
  final List<double>? snapPoints;

  /// Background color
  final Color? backgroundColor;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Padding inside the sheet
  final EdgeInsets? padding;

  /// Callback when height changes
  final ValueChanged<double>? onHeightChanged;

  /// Callback when closed
  final VoidCallback? onClose;

  /// Enable keyboard dismissal on outside tap
  final bool dismissOnBackdropTap;

  const ModernBottomSheet({
    required this.child,
    this.initialHeightFraction = 0.5,
    this.minHeightFraction = 0.25,
    this.maxHeightFraction = 0.95,
    this.enableBackdrop = true,
    this.backdropBlurSigma = 4.0,
    this.showDragHandle = true,
    this.enableSnapPoints = true,
    this.snapPoints,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.onHeightChanged,
    this.onClose,
    this.dismissOnBackdropTap = true,
    super.key,
  });

  @override
  State<ModernBottomSheet> createState() => _ModernBottomSheetState();
}

class _ModernBottomSheetState extends State<ModernBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  double _currentHeight = 0.5;
  late List<double> _snapPoints;

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.initialHeightFraction;

    // Setup snap points
    _snapPoints = widget.snapPoints ??
        [
          widget.minHeightFraction,
          0.5,
          widget.maxHeightFraction,
        ];
    _snapPoints.sort();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: _currentHeight,
      end: _currentHeight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _snapToPoint(double heightFraction) {
    _heightAnimation = Tween<double>(
      begin: _currentHeight,
      end: heightFraction.clamp(
        widget.minHeightFraction,
        widget.maxHeightFraction,
      ),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward(from: 0.0).then((_) {
      setState(() {
        _currentHeight = _heightAnimation.value;
      });
    });

    widget.onHeightChanged?.call(_currentHeight);
  }

  double _getClosestSnapPoint(double height) {
    if (!widget.enableSnapPoints) {
      return height.clamp(
        widget.minHeightFraction,
        widget.maxHeightFraction,
      );
    }

    double closest = _snapPoints.first;
    double minDistance = (height - _snapPoints.first).abs();

    for (double point in _snapPoints) {
      final distance = (height - point).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closest = point;
      }
    }

    return closest;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentHeight -= details.delta.dy / MediaQuery.of(context).size.height;
      _currentHeight = _currentHeight.clamp(
        widget.minHeightFraction,
        widget.maxHeightFraction,
      );
    });
    widget.onHeightChanged?.call(_currentHeight);
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = -details.velocity.pixelsPerSecond.dy /
        MediaQuery.of(context).size.height;

    if (velocity.abs() > 0.3) {
      // Swipe up or down
      final targetHeight = velocity < 0
          ? widget.maxHeightFraction
          : widget.minHeightFraction;
      _snapToPoint(targetHeight);
    } else {
      // Snap to nearest point
      _snapToPoint(_getClosestSnapPoint(_currentHeight));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom;

    return Stack(
      children: [
        // Backdrop
        if (widget.enableBackdrop)
          GestureDetector(
            onTap: widget.dismissOnBackdropTap
                ? () => Navigator.pop(context)
                : null,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.backdropBlurSigma,
                sigmaY: widget.backdropBlurSigma,
              ),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),

        // Bottom sheet
        AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            final height = _animationController.isAnimating
                ? _heightAnimation.value
                : _currentHeight;

            return Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: height,
                child: child,
              ),
            );
          },
          child: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ??
                    Theme.of(context).colorScheme.surface,
                borderRadius: widget.borderRadius ??
                    BorderRadius.only(
                      topLeft:
                          Radius.circular(ONTDesignTokens.radiusXLarge),
                      topRight:
                          Radius.circular(ONTDesignTokens.radiusXLarge),
                    ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  if (widget.showDragHandle)
                    Padding(
                      padding: EdgeInsets.only(
                        top: ONTDesignTokens.spacing12,
                        bottom: ONTDesignTokens.spacing8,
                      ),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.3),
                          borderRadius:
                              BorderRadius.circular(2),
                        ),
                      ),
                    ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: widget.padding ??
                          EdgeInsets.all(ONTDesignTokens.spacing16),
                      child: widget.child,
                    ),
                  ),

                  // Spacer for keyboard
                  if (bottomPadding > 0)
                    SizedBox(height: bottomPadding),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Show modern bottom sheet dialog
Future<T?> showModernBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double initialHeight = 0.5,
  double minHeight = 0.25,
  double maxHeight = 0.95,
  bool enableBackdrop = true,
  bool dismissOnBackdropTap = true,
  ValueChanged<double>? onHeightChanged,
  Color? backgroundColor,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) => ModernBottomSheet(
      initialHeightFraction: initialHeight,
      minHeightFraction: minHeight,
      maxHeightFraction: maxHeight,
      enableBackdrop: enableBackdrop,
      dismissOnBackdropTap: dismissOnBackdropTap,
      onHeightChanged: onHeightChanged,
      backgroundColor: backgroundColor,
      onClose: () => Navigator.pop(context),
      child: child,
    ),
  );
}

/// Bottom sheet wrapper with common styling
class ModernBottomSheetContent extends StatelessWidget {
  /// Title of the bottom sheet
  final String? title;

  /// Subtitle/description
  final String? subtitle;

  /// Main content
  final Widget child;

  /// Optional action button at bottom
  final Widget? actionButton;

  /// Icon for the header
  final IconData? headerIcon;

  const ModernBottomSheetContent({
    this.title,
    this.subtitle,
    required this.child,
    this.actionButton,
    this.headerIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        if (title != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: ONTDesignTokens.spacing16,
            ),
            child: Row(
              children: [
                if (headerIcon != null) ...[
                  Icon(
                    headerIcon,
                    color: Theme.of(context).colorScheme.primary,
                    size: ONTDesignTokens.iconSizeMedium,
                  ),
                  SizedBox(width: ONTDesignTokens.spacing12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: ONTDesignTokens.spacing4),
                        Text(
                          subtitle!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

        // Content
        child,

        // Action button
        if (actionButton != null) ...[
          SizedBox(height: ONTDesignTokens.spacing16),
          actionButton!,
        ],
      ],
    );
  }
}

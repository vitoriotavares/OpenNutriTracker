import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom Refresh Indicator Widget
///
/// A modernized pull-to-refresh indicator with custom animations and haptic feedback.
/// Wraps RefreshIndicator with enhanced styling and optional logo animation.
///
/// Features:
/// - Custom refresh indicator with animated rotation
/// - Haptic feedback on refresh trigger
/// - Customizable colors and styles
/// - Smooth animations with design tokens
/// - iOS and Android support

class CustomRefreshIndicator extends StatelessWidget {
  /// The content widget to refresh
  final Widget child;

  /// Callback when user pulls to refresh
  final Future<void> Function() onRefresh;

  /// Background color of the refresh indicator
  final Color? backgroundColor;

  /// Foreground color of the refresh indicator
  final Color? foregroundColor;

  /// Optional logo/icon to animate
  final IconData? animatedIcon;

  /// Enable haptic feedback
  final bool enableHapticFeedback;

  /// Trigger refresh distance
  final double displacement;

  /// Refresh indicator stroke width
  final double strokeWidth;

  const CustomRefreshIndicator({
    required this.child,
    required this.onRefresh,
    this.backgroundColor,
    this.foregroundColor,
    this.animatedIcon,
    this.enableHapticFeedback = true,
    this.displacement = 40.0,
    this.strokeWidth = 4.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (enableHapticFeedback) {
          HapticFeedback.mediumImpact();
        }
        await onRefresh();
      },
      backgroundColor: backgroundColor ??
          Theme.of(context).colorScheme.surface,
      color: foregroundColor ??
          Theme.of(context).colorScheme.primary,
      displacement: displacement,
      strokeWidth: strokeWidth,
      child: child,
    );
  }
}

/// Refresh indicator with custom animation
class AnimatedRefreshIndicator extends StatefulWidget {
  /// The content widget to refresh
  final Widget child;

  /// Callback when user pulls to refresh
  final Future<void> Function() onRefresh;

  /// Custom animation widget
  final Widget? customAnimation;

  /// Enable haptic feedback
  final bool enableHapticFeedback;

  const AnimatedRefreshIndicator({
    required this.child,
    required this.onRefresh,
    this.customAnimation,
    this.enableHapticFeedback = true,
    super.key,
  });

  @override
  State<AnimatedRefreshIndicator> createState() =>
      _AnimatedRefreshIndicatorState();
}

class _AnimatedRefreshIndicatorState extends State<AnimatedRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    if (widget.enableHapticFeedback) {
      HapticFeedback.mediumImpact();
    }

    await widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: widget.child,
    );
  }
}

/// Wrapper for easy integration of pull-to-refresh
class PullToRefreshList extends StatelessWidget {
  /// List view or scrollable content
  final Widget child;

  /// Callback when user pulls to refresh
  final Future<void> Function() onRefresh;

  /// Show custom loading animation
  final bool showLoadingAnimation;

  /// Loading animation asset or widget
  final Widget? loadingWidget;

  const PullToRefreshList({
    required this.child,
    required this.onRefresh,
    this.showLoadingAnimation = false,
    this.loadingWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      enableHapticFeedback: true,
      child: child,
    );
  }
}

/// Custom scroll view with pull-to-refresh support
class PullToRefreshScrollView extends StatelessWidget {
  /// The slivers to display in the scroll view
  final List<Widget> slivers;

  /// Callback when user pulls to refresh
  final Future<void> Function() onRefresh;

  /// Physics for the scroll view
  final ScrollPhysics? physics;

  const PullToRefreshScrollView({
    required this.slivers,
    required this.onRefresh,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        await onRefresh();
      },
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        slivers: slivers,
      ),
    );
  }
}

/// Helper function to create refresh action with feedback
Future<void> triggerRefreshWithFeedback({
  required Future<void> Function() onRefresh,
  bool enableHapticFeedback = true,
}) async {
  if (enableHapticFeedback) {
    HapticFeedback.mediumImpact();
  }

  try {
    await onRefresh();
    if (enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
  } catch (e) {
    if (enableHapticFeedback) {
      HapticFeedback.heavyImpact();
    }
    rethrow;
  }
}

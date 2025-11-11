import 'package:flutter/material.dart';
import '../../styles/design_tokens.dart';

/// Shimmer Skeleton Loader
///
/// Provides skeleton loading screens that shimmer with a gradient effect
/// to indicate content is loading. Commonly used for meal cards, activity cards,
/// and dashboard components.

class ShimmerSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final bool isCircular;

  const ShimmerSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.margin,
    this.isCircular = false,
  });

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: widget.isCircular ? null : (widget.borderRadius ?? BorderRadius.circular(ONTDesignTokens.radiusLarge)),
        color: baseColor,
      ),
      child: ClipRRect(
        borderRadius: widget.isCircular ? BorderRadius.circular(widget.width / 2) : (widget.borderRadius ?? BorderRadius.circular(ONTDesignTokens.radiusLarge)),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(-1 - _controller.value * 2, 0),
                  end: Alignment(1 + _controller.value * 2, 0),
                  colors: [
                    highlightColor.withValues(alpha: 0),
                    highlightColor.withValues(alpha: 0.5),
                    highlightColor.withValues(alpha: 0),
                  ],
                ).createShader(bounds);
              },
              child: Container(
                color: baseColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Shimmer Card Skeleton - simulates meal/activity card loading
class ShimmerCardSkeleton extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerCardSkeleton({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerSkeleton(
              width: double.infinity,
              height: 24,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            ShimmerSkeleton(
              width: 120,
              height: 16,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerSkeleton(
                  width: 80,
                  height: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
                ShimmerSkeleton(
                  width: 60,
                  height: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer Dashboard Skeleton - simulates dashboard loading
class ShimmerDashboardSkeleton extends StatelessWidget {
  const ShimmerDashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calorie ring skeleton
            Center(
              child: ShimmerSkeleton(
                width: 200,
                height: 200,
                isCircular: true,
              ),
            ),
            const SizedBox(height: 24),
            // Macro indicators skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShimmerSkeleton(
                  width: 80,
                  height: 80,
                  isCircular: true,
                ),
                ShimmerSkeleton(
                  width: 80,
                  height: 80,
                  isCircular: true,
                ),
                ShimmerSkeleton(
                  width: 80,
                  height: 80,
                  isCircular: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Meal section skeleton
            ShimmerSkeleton(
              width: 100,
              height: 24,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ShimmerCardSkeleton(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer List Skeleton - for loading lists of items
class ShimmerListSkeleton extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsets? padding;

  const ShimmerListSkeleton({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 100,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding ?? const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ShimmerCardSkeleton(),
        );
      },
    );
  }
}

/// Shimmer Wrap - wraps a widget and shows shimmer loading until revealed
class ShimmerLoading extends StatefulWidget {
  final bool isLoading;
  final Widget loadingWidget;
  final Widget child;
  final Duration duration;

  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.loadingWidget,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    if (!widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ShimmerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isLoading && oldWidget.isLoading) {
      _controller.forward();
    } else if (widget.isLoading && !oldWidget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: widget.isLoading ? widget.loadingWidget : widget.child,
    );
  }
}

/// Pulse Progress Indicator - animated circle that fills like progress
class PulseProgressIndicator extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const PulseProgressIndicator({
    super.key,
    this.size = 40,
    this.strokeWidth = 3,
    this.color,
  });

  @override
  State<PulseProgressIndicator> createState() => _PulseProgressIndicatorState();
}

class _PulseProgressIndicatorState extends State<PulseProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CircularProgressIndicator(
                value: _controller.value,
                strokeWidth: widget.strokeWidth,
                valueColor: AlwaysStoppedAnimation(color),
              );
            },
          ),
          _PulseLoadingIcon(
            duration: const Duration(milliseconds: 1500),
            child: Icon(
              Icons.hourglass_empty,
              color: color,
              size: widget.size * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper for pulsing icon in progress indicator
class _PulseLoadingIcon extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _PulseLoadingIcon({
    required this.child,
    required this.duration,
  });

  @override
  State<_PulseLoadingIcon> createState() => _PulseLoadingIconState();
}

class _PulseLoadingIconState extends State<_PulseLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.4).animate(_controller),
      child: widget.child,
    );
  }
}

extension ShimmerSkeletonValues on ShimmerSkeleton {
  /// Skeleton for avatar/profile picture
  static ShimmerSkeleton avatar({double size = 40}) => ShimmerSkeleton(
    width: size,
    height: size,
    isCircular: true,
  );

  /// Skeleton for title text
  static ShimmerSkeleton title({double width = 200, double height = 24}) =>
      ShimmerSkeleton(
        width: width,
        height: height,
        borderRadius: BorderRadius.circular(4),
      );

  /// Skeleton for body text
  static ShimmerSkeleton text({double width = double.infinity, double height = 16}) =>
      ShimmerSkeleton(
        width: width,
        height: height,
        borderRadius: BorderRadius.circular(4),
      );

  /// Skeleton for button
  static ShimmerSkeleton button({double width = 100, double height = 44}) =>
      ShimmerSkeleton(
        width: width,
        height: height,
        borderRadius: BorderRadius.circular(8),
      );
}

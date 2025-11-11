import 'package:flutter/material.dart';

import '../../styles/color_schemes.dart';
import '../../styles/design_tokens.dart';

/// Enhanced Calorie Ring Chart
///
/// A visually appealing ring/donut chart that displays daily calorie intake progress.
/// Features include:
/// - Animated transitions between values
/// - Gradient color coding (green → yellow → red based on progress)
/// - Inner shadow effect for depth
/// - Responsive sizing based on screen constraints
/// - Dual-ring design: inner (consumed) and outer (goal)
///
/// The ring color changes based on progress:
/// - Green: Normal intake (0-80% of goal)
/// - Yellow: Approaching goal (80-100% of goal)
/// - Red: Over goal (>100% of goal)

class CalorieRingChart extends StatefulWidget {
  /// Current calorie intake for the day
  final double consumedCalories;

  /// Daily calorie goal
  final double goalCalories;

  /// Optional custom radius (defaults to 140)
  final double? radius;

  /// Optional callback when ring is tapped
  final VoidCallback? onTap;

  /// Show internal text labels
  final bool showLabels;

  /// Animation duration
  final Duration animationDuration;

  const CalorieRingChart({
    required this.consumedCalories,
    required this.goalCalories,
    this.radius,
    this.onTap,
    this.showLabels = true,
    this.animationDuration = const Duration(milliseconds: 800),
    super.key,
  });

  @override
  State<CalorieRingChart> createState() => _CalorieRingChartState();
}

class _CalorieRingChartState extends State<CalorieRingChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: _calculateProgress(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ONTDesignTokens.curveStandard,
      ),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(CalorieRingChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.consumedCalories != widget.consumedCalories ||
        oldWidget.goalCalories != widget.goalCalories) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: _calculateProgress(),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: ONTDesignTokens.curveStandard,
        ),
      );
      _animationController.forward(from: 0.0);
    }
  }

  double _calculateProgress() {
    if (widget.goalCalories <= 0) return 0.0;
    return (widget.consumedCalories / widget.goalCalories).clamp(0.0, 1.5);
  }

  Color _getGradientColor(double progress) {
    // Progress-based color: green (0-0.8) → yellow (0.8-1.0) → red (1.0+)
    if (progress <= 0.8) {
      // Green (0-80%)
      return gradientCalorieRing[0]; // Green
    } else if (progress <= 1.0) {
      // Yellow (80-100%)
      return gradientCalorieRing[1]; // Amber
    } else {
      // Red (100%+)
      return gradientCalorieRing[2]; // Red
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 360;

    // Responsive radius calculation
    double radius = widget.radius ?? 140;
    if (isSmallScreen) {
      radius = 120;
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SizedBox(
            width: radius * 2 + ONTDesignTokens.spacing16,
            height: radius * 2 + ONTDesignTokens.spacing16,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background ring (goal indicator)
                CustomPaint(
                  size: Size(radius * 2, radius * 2),
                  painter: CalorieRingPainter(
                    progress: 1.0,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    strokeWidth: 12,
                    drawShadow: false,
                  ),
                ),

                // Progress ring (consumed)
                CustomPaint(
                  size: Size(radius * 2, radius * 2),
                  painter: CalorieRingPainter(
                    progress: _animation.value,
                    color: _getGradientColor(_animation.value),
                    strokeWidth: 12,
                    drawShadow: true,
                    shadowColor: _getGradientColor(_animation.value),
                  ),
                ),

                // Center content
                if (widget.showLabels)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.consumedCalories.toStringAsFixed(0),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                              fontSize: isSmallScreen ? 48 : 56,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                      ),
                      SizedBox(height: ONTDesignTokens.spacing4),
                      Text(
                        'kcal',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      SizedBox(height: ONTDesignTokens.spacing8),
                      Text(
                        'of ${widget.goalCalories.toStringAsFixed(0)}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Custom painter for drawing the calorie ring
class CalorieRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool drawShadow;
  final Color? shadowColor;

  CalorieRingPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 12,
    this.drawShadow = false,
    this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Draw shadow effect (optional inner shadow)
    if (drawShadow && shadowColor != null) {
      final shadowPaint = Paint()
        ..color = shadowColor!.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius + 1),
        -90 * (3.14159 / 180),
        360 * (3.14159 / 180),
        false,
        shadowPaint,
      );
    }

    // Draw progress arc
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Arc from top (-90 degrees) clockwise
    final sweepAngle = 360 * progress * (3.14159 / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.14159 / 180), // Start from top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CalorieRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// Responsive calorie ring that adapts to different screen sizes
class ResponsiveCalorieRingChart extends StatelessWidget {
  final double consumedCalories;
  final double goalCalories;
  final VoidCallback? onTap;

  const ResponsiveCalorieRingChart({
    required this.consumedCalories,
    required this.goalCalories,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive radius based on available width
        double radius = (constraints.maxWidth / 2) - ONTDesignTokens.spacing24;
        radius = radius.clamp(100, 160); // Min 100, Max 160

        return Center(
          child: CalorieRingChart(
            consumedCalories: consumedCalories,
            goalCalories: goalCalories,
            radius: radius,
            onTap: onTap,
          ),
        );
      },
    );
  }
}

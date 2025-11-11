import 'package:flutter/material.dart';

import '../../styles/color_schemes.dart';
import '../../styles/design_tokens.dart';

/// Macro Nutrient data model
class MacroData {
  final double protein;
  final double carbs;
  final double fat;

  /// Optional: individual goals for each macro (for percentage calculation)
  final double? proteinGoal;
  final double? carbsGoal;
  final double? fatGoal;

  MacroData({
    required this.protein,
    required this.carbs,
    required this.fat,
    this.proteinGoal,
    this.carbsGoal,
    this.fatGoal,
  });

  /// Total macros in grams
  double get total => protein + carbs + fat;

  /// Get percentage of total
  double getPercentage(double value) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }

  /// Get percentage of individual goal
  double? getGoalPercentage(double value, double? goal) {
    if (goal == null || goal == 0) return null;
    return (value / goal) * 100;
  }
}

/// Macro Nutrient Visualization Widget
///
/// Displays protein, carbohydrates, and fat in color-coded circular indicators
/// with percentage labels and optional expandable details.
///
/// Features:
/// - Color-coded indicators (blue, orange, yellow)
/// - Animated value transitions
/// - Percentage displays
/// - Tap to expand for detailed breakdown
/// - Responsive layout

class MacroIndicators extends StatefulWidget {
  /// Macro nutrient data
  final MacroData macroData;

  /// Optional title
  final String? title;

  /// Show percentage based on total or goals
  final bool showPercentage;

  /// Make widget expandable
  final bool expandable;

  /// Callback when expanded
  final VoidCallback? onExpanded;

  /// Custom radius for circular indicators
  final double? indicatorRadius;

  /// Animation duration
  final Duration animationDuration;

  const MacroIndicators({
    required this.macroData,
    this.title,
    this.showPercentage = true,
    this.expandable = true,
    this.onExpanded,
    this.indicatorRadius,
    this.animationDuration = const Duration(milliseconds: 600),
    super.key,
  });

  @override
  State<MacroIndicators> createState() => _MacroIndicatorsState();
}

class _MacroIndicatorsState extends State<MacroIndicators>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    if (widget.expandable) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
      widget.onExpanded?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title (optional)
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.only(
                bottom: ONTDesignTokens.spacing12,
              ),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

          // Main macro indicators row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MacroIndicator(
                label: 'Protein',
                value: widget.macroData.protein,
                goal: widget.macroData.proteinGoal,
                color: colorProtein,
                animationDuration: widget.animationDuration,
                showPercentage: widget.showPercentage,
                indicatorRadius: widget.indicatorRadius,
              ),
              _MacroIndicator(
                label: 'Carbs',
                value: widget.macroData.carbs,
                goal: widget.macroData.carbsGoal,
                color: colorCarbs,
                animationDuration: widget.animationDuration,
                showPercentage: widget.showPercentage,
                indicatorRadius: widget.indicatorRadius,
              ),
              _MacroIndicator(
                label: 'Fat',
                value: widget.macroData.fat,
                goal: widget.macroData.fatGoal,
                color: colorFat,
                animationDuration: widget.animationDuration,
                showPercentage: widget.showPercentage,
                indicatorRadius: widget.indicatorRadius,
              ),
            ],
          ),

          // Expanded details
          if (_isExpanded && widget.expandable)
            Padding(
              padding: EdgeInsets.only(
                top: ONTDesignTokens.spacing16,
              ),
              child: _MacroBreakdown(
                macroData: widget.macroData,
              ),
            ),

          // Expand hint (if expandable and not expanded)
          if (widget.expandable && !_isExpanded)
            Padding(
              padding: EdgeInsets.only(
                top: ONTDesignTokens.spacing8,
              ),
              child: Text(
                'Tap for details',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Individual macro indicator component
class _MacroIndicator extends StatefulWidget {
  final String label;
  final double value;
  final double? goal;
  final Color color;
  final Duration animationDuration;
  final bool showPercentage;
  final double? indicatorRadius;

  const _MacroIndicator({
    required this.label,
    required this.value,
    required this.goal,
    required this.color,
    required this.animationDuration,
    required this.showPercentage,
    required this.indicatorRadius,
  });

  @override
  State<_MacroIndicator> createState() => _MacroIndicatorState();
}

class _MacroIndicatorState extends State<_MacroIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.value,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: ONTDesignTokens.curveStandard,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(_MacroIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: ONTDesignTokens.curveStandard,
        ),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.indicatorRadius ?? 50.0;
    final percentage = widget.goal != null && widget.goal! > 0
        ? (widget.value / widget.goal!) * 100
        : null;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular indicator
            Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: radius * 2,
                  height: radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                  ),
                ),

                // Progress ring (simplified - just solid circle with percentage)
                SizedBox(
                  width: radius * 2,
                  height: radius * 2,
                  child: CustomPaint(
                    painter: _MacroRingPainter(
                      progress: percentage != null
                          ? (percentage / 100).clamp(0, 1)
                          : 0,
                      color: widget.color,
                      strokeWidth: 4,
                    ),
                  ),
                ),

                // Center text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _animation.value.toStringAsFixed(0),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: widget.color,
                          ),
                    ),
                    Text(
                      'g',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: ONTDesignTokens.spacing8),

            // Label
            Text(
              widget.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            // Percentage (if available)
            if (widget.showPercentage && percentage != null)
              Padding(
                padding: EdgeInsets.only(top: ONTDesignTokens.spacing4),
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Macro ring painter for progress visualization
class _MacroRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _MacroRingPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw progress arc from top
    final sweepAngle = 360 * progress * (3.14159 / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.14159 / 180),
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_MacroRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

/// Expanded breakdown view
class _MacroBreakdown extends StatelessWidget {
  final MacroData macroData;

  const _MacroBreakdown({
    required this.macroData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ONTDesignTokens.spacing12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
      ),
      child: Column(
        children: [
          _BreakdownRow(
            label: 'Protein',
            value: macroData.protein,
            unit: 'g',
            percentage: macroData.getPercentage(macroData.protein),
            color: colorProtein,
          ),
          SizedBox(height: ONTDesignTokens.spacing8),
          _BreakdownRow(
            label: 'Carbs',
            value: macroData.carbs,
            unit: 'g',
            percentage: macroData.getPercentage(macroData.carbs),
            color: colorCarbs,
          ),
          SizedBox(height: ONTDesignTokens.spacing8),
          _BreakdownRow(
            label: 'Fat',
            value: macroData.fat,
            unit: 'g',
            percentage: macroData.getPercentage(macroData.fat),
            color: colorFat,
          ),
          SizedBox(height: ONTDesignTokens.spacing12),
          Divider(height: ONTDesignTokens.spacing8),
          SizedBox(height: ONTDesignTokens.spacing8),
          _BreakdownRow(
            label: 'Total',
            value: macroData.total,
            unit: 'g',
            percentage: 100,
            color: Theme.of(context).colorScheme.primary,
            isBold: true,
          ),
        ],
      ),
    );
  }
}

/// Individual breakdown row
class _BreakdownRow extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final double percentage;
  final Color color;
  final bool isBold;

  const _BreakdownRow({
    required this.label,
    required this.value,
    required this.unit,
    required this.percentage,
    required this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label with color indicator
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            SizedBox(width: ONTDesignTokens.spacing8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),

        // Value and percentage
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${value.toStringAsFixed(1)} $unit',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Responsive macro indicators that adapt to screen width
class ResponsiveMacroIndicators extends StatelessWidget {
  final MacroData macroData;
  final String? title;
  final VoidCallback? onExpanded;

  const ResponsiveMacroIndicators({
    required this.macroData,
    this.title,
    this.onExpanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust indicator radius based on screen width
        final availableWidth = constraints.maxWidth;
        final indicatorRadius = (availableWidth / 6).clamp(40.0, 60.0);

        return MacroIndicators(
          macroData: macroData,
          title: title,
          indicatorRadius: indicatorRadius,
          onExpanded: onExpanded,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/styles/color_schemes.dart';
import '../../../../core/styles/design_tokens.dart';
import '../../../../core/widgets/cards/modern_card.dart';
import '../../../../core/widgets/charts/macro_indicators.dart';

/// Compact Horizontal Macro Nutrient Display
///
/// Shows protein, carbs, and fat as horizontal progress bars instead of circles.
/// More space-efficient than circular indicators while providing clear progress visualization.
///
/// Features:
/// - Horizontal progress bars with gradient fills
/// - Shows current vs goal values
/// - Percentage indicators
/// - Color-coded by macro type
/// - Compact height (~100px total)

class MacrosHorizontalBars extends StatelessWidget {
  /// Macro nutrient data
  final MacroData macroData;

  /// Optional callback when macro details are tapped
  final VoidCallback? onTap;

  const MacrosHorizontalBars({
    required this.macroData,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ONTDesignTokens.spacing16),
      child: ModernCard(
        padding: EdgeInsets.all(ONTDesignTokens.spacing16),
        elevation: 0,
        variant: ModernCardVariant.outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Protein bar
            _MacroBar(
              label: 'Protein',
              value: macroData.protein,
              goal: macroData.proteinGoal,
              color: colorProtein,
              unit: 'g',
            ),

            SizedBox(height: ONTDesignTokens.spacing12),

            // Carbs bar
            _MacroBar(
              label: 'Carbs',
              value: macroData.carbs,
              goal: macroData.carbsGoal,
              color: colorCarbs,
              unit: 'g',
            ),

            SizedBox(height: ONTDesignTokens.spacing12),

            // Fat bar
            _MacroBar(
              label: 'Fat',
              value: macroData.fat,
              goal: macroData.fatGoal,
              color: colorFat,
              unit: 'g',
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual horizontal macro bar with progress
class _MacroBar extends StatelessWidget {
  final String label;
  final double value;
  final double? goal;
  final Color color;
  final String unit;

  const _MacroBar({
    required this.label,
    required this.value,
    required this.goal,
    required this.color,
    required this.unit,
  });

  /// Calculate progress percentage (0.0 to 1.0+)
  double _getProgress() {
    if (goal == null || goal == 0) return 0;
    return (value / goal!).clamp(0, 1.2); // Allow up to 120% for visual feedback
  }

  /// Format goal text
  String _getGoalText() {
    if (goal == null) return '$value$unit';
    return '${value.toStringAsFixed(0)}/${ goal!.toStringAsFixed(0)}$unit';
  }

  /// Get percentage text
  String _getPercentageText() {
    if (goal == null || goal == 0) return '';
    final percentage = (value / goal!) * 100;
    return '${percentage.toStringAsFixed(0)}%';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _getProgress();
    final isExceeded = progress > 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label and value row
        Row(
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Goal text
            Text(
              _getGoalText(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),

        SizedBox(height: ONTDesignTokens.spacing4),

        // Progress bar with clipped animation
        Stack(
          children: [
            // Background bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ONTDesignTokens.radiusSmall),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),

            // Progress fill
            AnimatedFractionallySizedBox(
              widthFactor: progress.clamp(0, 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ONTDesignTokens.radiusSmall),
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withValues(alpha: 0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),

            // Exceeded indicator (if value > goal)
            if (isExceeded)
              Positioned(
                left: null,
                right: -40.0, // Position to the right of the bar
                child: Padding(
                  padding: EdgeInsets.only(left: ONTDesignTokens.spacing4),
                  child: Text(
                    '+${((progress - 1) * (goal ?? 100)).toStringAsFixed(0)}$unit',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),

        SizedBox(height: ONTDesignTokens.spacing4),

        // Percentage text
        if (goal != null && goal! > 0)
          Text(
            _getPercentageText(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isExceeded
                  ? color
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 11,
              fontWeight: isExceeded ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
      ],
    );
  }
}

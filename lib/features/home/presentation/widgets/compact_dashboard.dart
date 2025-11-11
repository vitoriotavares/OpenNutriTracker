import 'package:flutter/material.dart';

import '../../../../core/styles/design_tokens.dart';
import '../../../../core/utils/micro_interactions.dart';
import '../../../../core/widgets/cards/modern_card.dart';
import '../../../../core/widgets/charts/calorie_ring_chart.dart';

/// Compact Dashboard Widget - Optimized for "above the fold"
///
/// Space-efficient layout with calorie ring (140x140) and quick stats side-by-side.
/// Reduces vertical space by 25% compared to original dashboard while maintaining
/// visual impact and showing critical metrics.
///
/// Features:
/// - Compact calorie ring (140x140 instead of 200x200)
/// - Quick stats column on the right (in, remaining, out)
/// - Responsive layout that adapts to screen width
/// - Same visual polish as original but more space-efficient

class CompactDashboard extends StatelessWidget {
  final double totalKcalDaily;
  final double totalKcalLeft;
  final double totalKcalSupplied;
  final double totalKcalBurned;
  final VoidCallback? onCalorieRingTap;

  const CompactDashboard({
    required this.totalKcalDaily,
    required this.totalKcalLeft,
    required this.totalKcalSupplied,
    required this.totalKcalBurned,
    this.onCalorieRingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate remaining calories
    final double kcalLeft =
        totalKcalLeft > 0 ? totalKcalLeft : 0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ONTDesignTokens.spacing16,
        vertical: ONTDesignTokens.spacing12,
      ),
      child: ModernCard(
        padding: EdgeInsets.all(ONTDesignTokens.spacing16),
        margin: EdgeInsets.zero,
        elevation: 0,
        variant: ModernCardVariant.outlined,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Compact calorie ring
            GestureDetector(
              onTap: onCalorieRingTap,
              child: CalorieRingChart(
                consumedCalories: totalKcalSupplied,
                goalCalories: totalKcalDaily,
                radius: 70, // Compact size: 140x140 instead of 200x200
                showLabels: false, // Hide labels for more space
              ),
            ),

            SizedBox(width: ONTDesignTokens.spacing16),

            // Quick stats column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Calorie ring summary
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: totalKcalSupplied.toStringAsFixed(0),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                        ),
                        TextSpan(
                          text: ' / ${totalKcalDaily.toStringAsFixed(0)} kcal',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ONTDesignTokens.spacing12),

                  // Quick stats grid (3 rows)
                  _QuickStatRow(
                    icon: Icons.arrow_upward,
                    label: 'in',
                    value: totalKcalSupplied.toStringAsFixed(0),
                  ),

                  SizedBox(height: ONTDesignTokens.spacing8),

                  _QuickStatRow(
                    icon: Icons.track_changes,
                    label: 'remaining',
                    value: kcalLeft.toStringAsFixed(0),
                    isHighlight: kcalLeft > 0,
                  ),

                  SizedBox(height: ONTDesignTokens.spacing8),

                  _QuickStatRow(
                    icon: Icons.local_fire_department,
                    label: 'out',
                    value: totalKcalBurned.toStringAsFixed(0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual quick stat row
class _QuickStatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isHighlight;

  const _QuickStatRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            PulseAnimation(
              duration: const Duration(milliseconds: 2000),
              minOpacity: 0.7,
              child: Icon(
                icon,
                size: 16,
                color: isHighlight
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: ONTDesignTokens.spacing8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isHighlight
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

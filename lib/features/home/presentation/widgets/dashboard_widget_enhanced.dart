import 'package:flutter/material.dart';

import '../../../../core/styles/design_tokens.dart';
import '../../../../core/widgets/cards/modern_card.dart';
import '../../../../core/widgets/charts/calorie_ring_chart.dart';
import '../../../../core/widgets/charts/macro_indicators.dart';
import '../../../../generated/l10n.dart';

/// Enhanced Dashboard Widget
///
/// Replaces the original DashboardWidget with modern components:
/// - CalorieRingChart for visual calorie progress
/// - MacroIndicators for nutrition breakdown
/// - ModernCard for consistent styling
/// - Improved typography hierarchy and spacing

class DashboardWidgetEnhanced extends StatefulWidget {
  final double totalKcalDaily;
  final double totalKcalLeft;
  final double totalKcalSupplied;
  final double totalKcalBurned;
  final double totalCarbsIntake;
  final double totalFatsIntake;
  final double totalProteinsIntake;
  final double totalCarbsGoal;
  final double totalFatsGoal;
  final double totalProteinsGoal;

  const DashboardWidgetEnhanced({
    super.key,
    required this.totalKcalSupplied,
    required this.totalKcalBurned,
    required this.totalKcalDaily,
    required this.totalKcalLeft,
    required this.totalCarbsIntake,
    required this.totalFatsIntake,
    required this.totalProteinsIntake,
    required this.totalCarbsGoal,
    required this.totalFatsGoal,
    required this.totalProteinsGoal,
  });

  @override
  State<DashboardWidgetEnhanced> createState() =>
      _DashboardWidgetEnhancedState();
}

class _DashboardWidgetEnhancedState extends State<DashboardWidgetEnhanced> {
  @override
  Widget build(BuildContext context) {
    // Calculate remaining calories
    final double kcalLeft = widget.totalKcalLeft > 0
        ? widget.totalKcalLeft
        : 0;

    // Create macro data for indicators
    final macroData = MacroData(
      protein: widget.totalProteinsIntake,
      carbs: widget.totalCarbsIntake,
      fat: widget.totalFatsIntake,
      proteinGoal: widget.totalProteinsGoal,
      carbsGoal: widget.totalCarbsGoal,
      fatGoal: widget.totalFatsGoal,
    );

    return Padding(
      padding: EdgeInsets.all(ONTDesignTokens.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main calorie ring card
          ModernCard(
            padding: EdgeInsets.all(ONTDesignTokens.spacing24),
            margin: EdgeInsets.only(
              bottom: ONTDesignTokens.spacing16,
            ),
            elevation: 0,
            variant: ModernCardVariant.outlined,
            child: Column(
              children: [
                // Calorie ring chart
                ResponsiveCalorieRingChart(
                  consumedCalories: widget.totalKcalSupplied,
                  goalCalories: widget.totalKcalDaily,
                  onTap: () {
                    // Optional: Show detailed calorie breakdown
                    _showCalorieDetails(context);
                  },
                ),

                SizedBox(height: ONTDesignTokens.spacing24),

                // Calorie summary row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _CalorieSummaryItem(
                      label: S.of(context).suppliedLabel,
                      value: widget.totalKcalSupplied.toStringAsFixed(0),
                      subtitle: 'kcal in',
                      icon: Icons.arrow_upward,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    _CalorieSummaryItem(
                      label: S.of(context).kcalLeftLabel,
                      value: kcalLeft.toStringAsFixed(0),
                      subtitle: 'remaining',
                      icon: Icons.arrow_downward,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    _CalorieSummaryItem(
                      label: 'Burned',
                      value: widget.totalKcalBurned.toStringAsFixed(0),
                      subtitle: 'kcal out',
                      icon: Icons.local_fire_department,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Macro nutrients card
          ModernCard(
            padding: EdgeInsets.all(ONTDesignTokens.spacing16),
            elevation: 0,
            variant: ModernCardVariant.outlined,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: ONTDesignTokens.spacing12,
                  ),
                  child: Text(
                    'Macronutrients',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                ResponsiveMacroIndicators(
                  macroData: macroData,
                  onExpanded: () {
                    // Optional: Show macro details
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCalorieDetails(BuildContext context) {
    // Placeholder for detailed calorie information dialog
    // This can be expanded later with more detailed information
  }
}

/// Calorie summary item component
class _CalorieSummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;

  const _CalorieSummaryItem({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: ONTDesignTokens.iconSizeMedium,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(height: ONTDesignTokens.spacing4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

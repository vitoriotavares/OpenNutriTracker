import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/presentation/widgets/meal_value_unit_text.dart';
import 'package:opennutritracker/core/styles/design_tokens.dart';
import 'package:opennutritracker/core/utils/locator.dart';

class IntakeCard extends StatelessWidget {
  final IntakeEntity intake;
  final Function(BuildContext, IntakeEntity)? onItemLongPressed;
  final Function(BuildContext, IntakeEntity, bool)? onItemTapped;
  final Function(BuildContext, IntakeEntity)? onLogAgainPressed;
  final bool firstListElement;
  final bool usesImperialUnits;

  const IntakeCard(
      {required super.key,
      required this.intake,
      this.onItemLongPressed,
      this.onItemTapped,
      this.onLogAgainPressed,
      required this.firstListElement,
      required this.usesImperialUnits});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        SizedBox(width: firstListElement ? ONTDesignTokens.spacing16 : 0),
        GestureDetector(
          onLongPress: onItemLongPressed != null
              ? () => onLongPressedItem(context)
              : null,
          onTap: onItemTapped != null
              ? () => onTappedItem(context, usesImperialUnits)
              : null,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isDarkMode ? 0.3 : 0.12,
                  ),
                  blurRadius: ONTDesignTokens.elevationCard * 2,
                  offset: Offset(0, ONTDesignTokens.elevationCard),
                  spreadRadius: ONTDesignTokens.elevationCard * 0.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
              child: Stack(
                children: [
                  // Background image
                  if (intake.meal.mainImageUrl != null)
                    CachedNetworkImage(
                      cacheManager: locator<CacheManager>(),
                      imageUrl: intake.meal.mainImageUrl ?? "",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.restaurant_outlined,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    )
                  else
                    Container(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      child: Center(
                        child: Icon(Icons.restaurant_outlined,
                            size: ONTDesignTokens.iconSizeMedium,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),

                  // Enhanced overlay for better text contrast
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),

                  // Calorie badge
                  Positioned(
                    top: ONTDesignTokens.spacing8,
                    right: ONTDesignTokens.spacing8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ONTDesignTokens.spacing8,
                            vertical: ONTDesignTokens.spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(
                                ONTDesignTokens.radiusSmall),
                          ),
                          child: Text(
                            '${intake.totalKcal.toInt()} kcal',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Log Again button
                        if (onLogAgainPressed != null)
                          SizedBox(width: ONTDesignTokens.spacing4),
                        if (onLogAgainPressed != null)
                          GestureDetector(
                            onTap: () => onLogAgainPressed!(context, intake),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Meal info at bottom
                  Positioned(
                    bottom: ONTDesignTokens.spacing8,
                    left: ONTDesignTokens.spacing8,
                    right: ONTDesignTokens.spacing8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          intake.meal.name ?? "?",
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ONTDesignTokens.spacing4),
                        MealValueUnitText(
                          value: intake.amount,
                          meal: intake.meal,
                          usesImperialUnits: usesImperialUnits,
                          textStyle:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onLongPressedItem(BuildContext context) {
    onItemLongPressed?.call(context, intake);
  }

  void onTappedItem(BuildContext context, bool usesImperialUnits) {
    onItemTapped?.call(context, intake, usesImperialUnits);
  }
}

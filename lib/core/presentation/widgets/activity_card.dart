import 'package:flutter/material.dart';
import 'package:opennutritracker/core/domain/entity/user_activity_entity.dart';
import 'package:opennutritracker/core/styles/design_tokens.dart';

class ActivityCard extends StatelessWidget {
  final UserActivityEntity activityEntity;
  final Function(BuildContext, UserActivityEntity) onItemLongPressed;
  final bool firstListElement;

  const ActivityCard(
      {super.key,
      required this.activityEntity,
      required this.onItemLongPressed,
      required this.firstListElement});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        SizedBox(
          width: firstListElement ? ONTDesignTokens.spacing16 : 0,
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onLongPress: () => onLongPressedItem(context),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ONTDesignTokens.radiusLarge),
                    color: Theme.of(context).colorScheme.surfaceContainer,
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
                    borderRadius:
                        BorderRadius.circular(ONTDesignTokens.radiusLarge),
                    child: Stack(
                      children: [
                        // Background with gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.1),
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.05),
                              ],
                            ),
                          ),
                        ),

                        // Activity icon centered
                        Center(
                          child: Icon(
                            activityEntity.physicalActivityEntity.displayIcon,
                            size: ONTDesignTokens.iconSizeLarge,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        // Calories badge
                        Positioned(
                          top: ONTDesignTokens.spacing8,
                          right: ONTDesignTokens.spacing8,
                          child: Container(
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
                              "🔥 ${activityEntity.burnedKcal.toInt()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ONTDesignTokens.spacing8,
                  top: ONTDesignTokens.spacing4,
                ),
                child: Text(
                  activityEntity.physicalActivityEntity.getName(context),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ONTDesignTokens.spacing8,
                  top: 2,
                ),
                child: Text(
                  '${activityEntity.duration.toInt()} min',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void onLongPressedItem(BuildContext context) {
    onItemLongPressed(context, activityEntity);
  }
}

import 'package:flutter/material.dart';

import '../../../../core/domain/entity/user_activity_entity.dart';
import '../../../../core/styles/design_tokens.dart';
import '../../../../core/widgets/cards/modern_card.dart';
import '../../../../generated/l10n.dart';

/// Activity Preview Widget - Shows first activity above the fold
///
/// Compact preview of the first activity logged today.
/// Creates visual connection between metrics and actions performed.
/// Motivates user to add more activities.
///
/// Features:
/// - Shows first activity as horizontal card
/// - Displays activity icon, name, duration, and calories burned
/// - Compact design (~70px height)
/// - Links to activities section below

class ActivityPreview extends StatelessWidget {
  /// First activity of the day (null if no activities logged)
  final UserActivityEntity? firstActivity;

  /// Callback when activity is tapped
  final VoidCallback? onTap;

  /// Callback to open activity details
  final Function(UserActivityEntity)? onActivityTap;

  const ActivityPreview({
    this.firstActivity,
    this.onTap,
    this.onActivityTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Don't show preview if no activity
    if (firstActivity == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ONTDesignTokens.spacing16,
        vertical: ONTDesignTokens.spacing12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.only(bottom: ONTDesignTokens.spacing8),
            child: Row(
              children: [
                Text(
                  S.of(context).activityLabel,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),

          // Activity card
          GestureDetector(
            onTap: onActivityTap != null
                ? () => onActivityTap!(firstActivity!)
                : onTap,
            child: ModernCard(
              padding: EdgeInsets.symmetric(
                horizontal: ONTDesignTokens.spacing12,
                vertical: ONTDesignTokens.spacing12,
              ),
              margin: EdgeInsets.zero,
              elevation: 0,
              variant: ModernCardVariant.outlined,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Activity icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: Icon(
                        firstActivity!.physicalActivityEntity.displayIcon,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  SizedBox(width: ONTDesignTokens.spacing12),

                  // Activity details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          firstActivity!.physicalActivityEntity
                              .getName(context),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ONTDesignTokens.spacing4),
                        Text(
                          '${firstActivity!.duration.toInt()} min',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Calories burned badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ONTDesignTokens.spacing8,
                      vertical: ONTDesignTokens.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        ONTDesignTokens.radiusSmall,
                      ),
                    ),
                    child: Text(
                      '🔥 ${firstActivity!.burnedKcal.toInt()}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

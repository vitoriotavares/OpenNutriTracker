import 'package:flutter/material.dart';

import '../../../../core/styles/design_tokens.dart';
import '../../../../core/widgets/cards/modern_card.dart';

/// Dynamic Greeting Card with contextual message
///
/// Shows personalized greeting based on time of day and daily progress.
/// Creates emotional connection and provides motivational context.
///
/// Features:
/// - Time-aware greetings (Good morning/afternoon/evening)
/// - Dynamic motivational messages based on progress
/// - Compact design (60px height)
/// - Displays meal and activity count for the day

class GreetingCard extends StatelessWidget {
  /// User's first name for personalization
  final String? userName;

  /// Calorie progress from 0.0 to 1.0+ (1.0 = daily goal reached)
  final double calorieProgress;

  /// Total meals logged today
  final int mealsLogged;

  /// Total activities logged today
  final int activitiesLogged;

  const GreetingCard({
    required this.calorieProgress,
    this.userName,
    this.mealsLogged = 0,
    this.activitiesLogged = 0,
    super.key,
  });

  /// Get greeting based on time of day
  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  /// Get motivational message based on calorie progress
  String _getMotivation() {
    if (calorieProgress < 0.25) return 'Start strong today! 💪';
    if (calorieProgress < 0.50) return 'Off to a great start! 🎯';
    if (calorieProgress < 0.75) return 'You\'re on track! 📈';
    if (calorieProgress < 1.0) return 'Almost there! 🔥';
    if (calorieProgress < 1.2) return 'Goal reached! 🎉';
    return 'Mindful eating today 🧘';
  }

  /// Get progress summary (e.g., "2 meals • 1 activity")
  String _getSummary() {
    List<String> parts = [];

    if (mealsLogged > 0) {
      parts.add('$mealsLogged ${mealsLogged == 1 ? 'meal' : 'meals'}');
    }

    if (activitiesLogged > 0) {
      parts.add('$activitiesLogged ${activitiesLogged == 1 ? 'activity' : 'activities'}');
    }

    if (parts.isEmpty) {
      return 'Ready to log your day';
    }

    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ONTDesignTokens.spacing16,
        ONTDesignTokens.spacing8,
        ONTDesignTokens.spacing16,
        ONTDesignTokens.spacing12,
      ),
      child: ModernCard(
        padding: EdgeInsets.symmetric(
          horizontal: ONTDesignTokens.spacing16,
          vertical: ONTDesignTokens.spacing12,
        ),
        elevation: 0,
        variant: ModernCardVariant.outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Greeting with name
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${_getGreeting(context)}${userName != null ? ', ${userName!}' : ''}!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' ${_getEmoji()}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            SizedBox(height: ONTDesignTokens.spacing8),

            // Motivation message
            Text(
              _getMotivation(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: ONTDesignTokens.spacing4),

            // Summary (meals + activities)
            Text(
              _getSummary(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get emoji based on time of day
  String _getEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 5) return '🌙';
    if (hour < 12) return '🌅';
    if (hour < 17) return '☀️';
    if (hour < 21) return '🌆';
    return '🌙';
  }
}

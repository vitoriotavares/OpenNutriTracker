import 'package:flutter/material.dart';

import '../../styles/design_tokens.dart';

/// Meal Category Icons
///
/// Provides a consistent icon system for different meal types throughout the app.
/// Each meal type has an associated icon, color, and semantic meaning.

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  snack,
}

/// Meal category icon metadata
class MealCategoryIcon {
  final MealCategory category;
  final IconData icon;
  final Color color;
  final String label;
  final String description;

  const MealCategoryIcon({
    required this.category,
    required this.icon,
    required this.color,
    required this.label,
    required this.description,
  });
}

/// Meal Category Icon System
///
/// Centralized system for managing meal category icons and their properties.
class MealCategoryIconSystem {
  /// Get icon metadata for a meal category
  static MealCategoryIcon getIconMetadata(MealCategory category) {
    return switch (category) {
      MealCategory.breakfast => MealCategoryIcon(
        category: MealCategory.breakfast,
        icon: Icons.coffee,
        color: const Color(0xFFF5A623), // Orange (matches carbs color)
        label: 'Breakfast',
        description: 'Morning meal',
      ),
      MealCategory.lunch => MealCategoryIcon(
        category: MealCategory.lunch,
        icon: Icons.lunch_dining,
        color: const Color(0xFF4A90E2), // Blue (matches protein color)
        label: 'Lunch',
        description: 'Midday meal',
      ),
      MealCategory.dinner => MealCategoryIcon(
        category: MealCategory.dinner,
        icon: Icons.dinner_dining,
        color: const Color(0xFFFFC107), // Amber (matches fat color)
        label: 'Dinner',
        description: 'Evening meal',
      ),
      MealCategory.snack => MealCategoryIcon(
        category: MealCategory.snack,
        icon: Icons.apple,
        color: const Color(0xFF4CAF50), // Green (success/health)
        label: 'Snack',
        description: 'Light bite',
      ),
    };
  }

  /// Get icon data for a meal category
  static IconData getIcon(MealCategory category) {
    return getIconMetadata(category).icon;
  }

  /// Get color for a meal category
  static Color getColor(MealCategory category) {
    return getIconMetadata(category).color;
  }

  /// Get label for a meal category
  static String getLabel(MealCategory category) {
    return getIconMetadata(category).label;
  }
}

/// Styled meal category icon widget
class MealCategoryIconWidget extends StatelessWidget {
  final MealCategory category;
  final double size;
  final bool showLabel;
  final bool showBackground;

  const MealCategoryIconWidget({
    required this.category,
    this.size = ONTDesignTokens.iconSizeMedium,
    this.showLabel = false,
    this.showBackground = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconMetadata = MealCategoryIconSystem.getIconMetadata(category);

    if (showBackground) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size + ONTDesignTokens.spacing8,
            height: size + ONTDesignTokens.spacing8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconMetadata.color.withValues(alpha: 0.15),
            ),
            child: Center(
              child: Icon(
                iconMetadata.icon,
                size: size,
                color: iconMetadata.color,
              ),
            ),
          ),
          if (showLabel) ...[
            SizedBox(height: ONTDesignTokens.spacing8),
            Text(
              iconMetadata.label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ]
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconMetadata.icon,
          size: size,
          color: iconMetadata.color,
        ),
        if (showLabel) ...[
          SizedBox(height: ONTDesignTokens.spacing8),
          Text(
            iconMetadata.label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ]
      ],
    );
  }
}

/// Meal category icon button (for UI actions)
class MealCategoryIconButton extends StatelessWidget {
  final MealCategory category;
  final VoidCallback? onPressed;
  final double iconSize;
  final bool showLabel;

  const MealCategoryIconButton({
    required this.category,
    this.onPressed,
    this.iconSize = ONTDesignTokens.iconSizeMedium,
    this.showLabel = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconMetadata = MealCategoryIconSystem.getIconMetadata(category);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ONTDesignTokens.touchTargetSmall,
          height: ONTDesignTokens.touchTargetSmall,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconMetadata.color.withValues(alpha: 0.1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              child: Center(
                child: Icon(
                  iconMetadata.icon,
                  size: iconSize,
                  color: iconMetadata.color,
                ),
              ),
            ),
          ),
        ),
        if (showLabel) ...[
          SizedBox(height: ONTDesignTokens.spacing8),
          Text(
            iconMetadata.label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}

/// Meal category icon selector (for choosing meal types)
class MealCategorySelector extends StatefulWidget {
  final MealCategory? initialCategory;
  final Function(MealCategory)? onCategorySelected;
  final List<MealCategory> availableCategories;

  const MealCategorySelector({
    this.initialCategory,
    this.onCategorySelected,
    this.availableCategories = const [
      MealCategory.breakfast,
      MealCategory.lunch,
      MealCategory.dinner,
      MealCategory.snack,
    ],
    super.key,
  });

  @override
  State<MealCategorySelector> createState() => _MealCategorySelectorState();
}

class _MealCategorySelectorState extends State<MealCategorySelector> {
  late MealCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? MealCategory.breakfast;
  }

  void _selectCategory(MealCategory category) {
    setState(() {
      _selectedCategory = category;
    });
    widget.onCategorySelected?.call(category);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.availableCategories
          .map((category) => _CategoryOption(
            category: category,
            isSelected: _selectedCategory == category,
            onTap: () => _selectCategory(category),
          ))
          .toList(),
    );
  }
}

/// Individual category option in selector
class _CategoryOption extends StatelessWidget {
  final MealCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryOption({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconMetadata = MealCategoryIconSystem.getIconMetadata(category);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: ONTDesignTokens.touchTargetDefault,
            height: ONTDesignTokens.touchTargetDefault,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? iconMetadata.color.withValues(alpha: 0.2)
                  : iconMetadata.color.withValues(alpha: 0.08),
              border: isSelected
                  ? Border.all(
                color: iconMetadata.color,
                width: 2,
              )
                  : null,
            ),
            child: Center(
              child: Icon(
                iconMetadata.icon,
                size: ONTDesignTokens.iconSizeMedium,
                color: iconMetadata.color,
              ),
            ),
          ),
          SizedBox(height: ONTDesignTokens.spacing8),
          Text(
            iconMetadata.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? iconMetadata.color
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

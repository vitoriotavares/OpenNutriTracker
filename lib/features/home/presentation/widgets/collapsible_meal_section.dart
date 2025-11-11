import 'package:flutter/material.dart';

import '../../../../core/styles/design_tokens.dart';

/// Collapsible Meal Section Widget
///
/// A customizable section that displays meal information (breakfast, lunch, etc.)
/// and can be expanded/collapsed to show/hide meal items.
///
/// Features:
/// - Smooth expand/collapse animation
/// - Customizable header with icon and title
/// - Calorie summary display
/// - Persistent state management
/// - Empty state support
/// - Custom content builder

class CollapsibleMealSection extends StatefulWidget {
  /// Section title (e.g., "Breakfast", "Lunch")
  final String title;

  /// Icon for the section
  final IconData icon;

  /// Total calories in this section
  final double totalCalories;

  /// Goal calories for this section (optional, for progress display)
  final double? goalCalories;

  /// The meal items/content to display
  final Widget child;

  /// Initially expanded
  final bool initiallyExpanded;

  /// Empty state message
  final String? emptyStateMessage;

  /// Number of items in this section
  final int itemCount;

  /// Callback when expanded state changes
  final ValueChanged<bool>? onExpandedChanged;

  /// Header background color
  final Color? headerBackgroundColor;

  /// Custom trailing widget
  final Widget? trailingWidget;

  const CollapsibleMealSection({
    required this.title,
    required this.icon,
    required this.totalCalories,
    required this.child,
    this.goalCalories,
    this.initiallyExpanded = true,
    this.emptyStateMessage,
    this.itemCount = 0,
    this.onExpandedChanged,
    this.headerBackgroundColor,
    this.trailingWidget,
    super.key,
  });

  @override
  State<CollapsibleMealSection> createState() =>
      _CollapsibleMealSectionState();
}

class _CollapsibleMealSectionState extends State<CollapsibleMealSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _heightAnimation;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );

    if (_isExpanded) {
      _expandController.forward();
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }

    widget.onExpandedChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isEmpty = widget.itemCount == 0;

    return Column(
      children: [
        // Header
        GestureDetector(
          onTap: _toggleExpanded,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ONTDesignTokens.spacing16,
              vertical: ONTDesignTokens.spacing12,
            ),
            decoration: BoxDecoration(
              color: widget.headerBackgroundColor ??
                  (isDarkMode
                      ? Theme.of(context).colorScheme.surfaceContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ONTDesignTokens.radiusMedium),
                topRight: Radius.circular(ONTDesignTokens.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                // Icon
                Icon(
                  widget.icon,
                  size: ONTDesignTokens.iconSizeMedium,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: ONTDesignTokens.spacing12),

                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      if (widget.itemCount > 0)
                        SizedBox(height: ONTDesignTokens.spacing4),
                      if (widget.itemCount > 0)
                        Text(
                          '${widget.itemCount} ${widget.itemCount == 1 ? 'item' : 'items'}',
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
                ),

                // Calories display
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.totalCalories.toInt()} kcal',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (widget.goalCalories != null &&
                        widget.goalCalories! > 0)
                      SizedBox(height: ONTDesignTokens.spacing4),
                    if (widget.goalCalories != null &&
                        widget.goalCalories! > 0)
                      Text(
                        'of ${widget.goalCalories!.toInt()} kcal',
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

                SizedBox(width: ONTDesignTokens.spacing12),

                // Expand/Collapse icon
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.expand_more,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                // Custom trailing widget
                if (widget.trailingWidget != null) ...[
                  SizedBox(width: ONTDesignTokens.spacing8),
                  widget.trailingWidget!,
                ],
              ],
            ),
          ),
        ),

        // Content
        if (!isEmpty)
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: _heightAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ONTDesignTokens.radiusMedium),
                    bottomRight:
                        Radius.circular(ONTDesignTokens.radiusMedium),
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),

        // Empty state
        if (isEmpty && _isExpanded)
          Container(
            padding: EdgeInsets.all(ONTDesignTokens.spacing24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(ONTDesignTokens.radiusMedium),
                bottomRight:
                    Radius.circular(ONTDesignTokens.radiusMedium),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.restaurant_outlined,
                    size: ONTDesignTokens.iconSizeLarge,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.5),
                  ),
                  SizedBox(height: ONTDesignTokens.spacing12),
                  Text(
                    widget.emptyStateMessage ?? 'No meals logged',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Wrapper for easy collapsible meal section integration
class MealSectionList extends StatelessWidget {
  /// List of meal items
  final List<Widget> mealItems;

  /// Optional padding for the content
  final EdgeInsets? contentPadding;

  const MealSectionList({
    required this.mealItems,
    this.contentPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding ??
          EdgeInsets.all(ONTDesignTokens.spacing16),
      child: Column(
        children: mealItems,
      ),
    );
  }
}

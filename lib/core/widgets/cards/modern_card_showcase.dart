import 'package:flutter/material.dart';

import '../../styles/design_tokens.dart';
import 'modern_card.dart';

/// Modern Card Showcase - Demonstrates all 6 card variants
///
/// This widget displays all 6 ModernCard variants for design system reference:
/// 1. Standard - Elevated with shadow
/// 2. Outlined - Border-based with minimal shadow
/// 3. Flat - No elevation, minimal styling
/// 4. Filled - Colored background
/// 5. Gradient - With gradient overlay
/// 6. Glassmorphism - Blur effect background

class ModernCardShowcase extends StatelessWidget {
  final bool horizontal;
  final double spacing;

  const ModernCardShowcase({
    super.key,
    this.horizontal = false,
    this.spacing = ONTDesignTokens.spacing8,
  });

  @override
  Widget build(BuildContext context) {
    final variants = [
      _CardVariantDemo(
        title: '1. Standard',
        subtitle: 'Elevated with shadow',
        variant: ModernCardVariant.standard,
        color: Colors.teal,
      ),
      _CardVariantDemo(
        title: '2. Outlined',
        subtitle: 'Border-based',
        variant: ModernCardVariant.outlined,
        color: Colors.blue,
      ),
      _CardVariantDemo(
        title: '3. Flat',
        subtitle: 'Minimal style',
        variant: ModernCardVariant.flat,
        color: Colors.purple,
      ),
      _CardVariantDemo(
        title: '4. Filled',
        subtitle: 'Colored background',
        variant: ModernCardVariant.filled,
        color: Colors.orange,
      ),
      _CardVariantDemo(
        title: '5. Gradient',
        subtitle: 'With overlay',
        variant: ModernCardVariant.gradient,
        color: Colors.green,
      ),
      _CardVariantDemo(
        title: '6. Glassmorphism',
        subtitle: 'Blur effect',
        variant: ModernCardVariant.glassmorphism,
        color: Colors.pink,
      ),
    ];

    return Padding(
      padding: EdgeInsets.all(ONTDesignTokens.spacing16),
      child: horizontal
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  variants.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: spacing),
                    child: SizedBox(
                      width: 140,
                      child: variants[index],
                    ),
                  ),
                ),
              ),
            )
          : Column(
              children: List.generate(
                variants.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: variants[index],
                ),
              ),
            ),
    );
  }
}

/// Individual card variant demo
class _CardVariantDemo extends StatelessWidget {
  final String title;
  final String subtitle;
  final ModernCardVariant variant;
  final Color color;

  const _CardVariantDemo({
    required this.title,
    required this.subtitle,
    required this.variant,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      variant: variant,
      elevation: variant == ModernCardVariant.flat ? 0 : ONTDesignTokens.elevationCard,
      padding: EdgeInsets.all(ONTDesignTokens.spacing12),
      enableGlassmorphism: variant == ModernCardVariant.glassmorphism,
      gradient: variant == ModernCardVariant.gradient
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.6),
                color.withValues(alpha: 0.2),
              ],
            )
          : null,
      backgroundColor: variant == ModernCardVariant.filled
          ? color.withValues(alpha: 0.15)
          : null,
      border: variant == ModernCardVariant.outlined
          ? Border.all(
              color: color,
              width: 2,
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Icon(
              _getIconForVariant(variant),
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(height: ONTDesignTokens.spacing8),
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ONTDesignTokens.spacing4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconForVariant(ModernCardVariant variant) {
    return switch (variant) {
      ModernCardVariant.standard => Icons.card_giftcard,
      ModernCardVariant.outlined => Icons.border_style,
      ModernCardVariant.flat => Icons.layers,
      ModernCardVariant.filled => Icons.format_paint,
      ModernCardVariant.gradient => Icons.gradient,
      ModernCardVariant.glassmorphism => Icons.blur_on,
    };
  }
}

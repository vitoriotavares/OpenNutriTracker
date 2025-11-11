import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Micro-interactions Library
///
/// Provides reusable animation utilities for common UI interactions:
/// - Button scale feedback
/// - Card elevation changes
/// - Shimmer loading states
/// - Haptic feedback patterns

/// Tap feedback animation for buttons and cards
class TapFeedback extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Duration animationDuration;
  final double minScale;
  final Curve curve;
  final bool enableHaptic;

  const TapFeedback({
    super.key,
    required this.child,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 200),
    this.minScale = 0.95,
    this.curve = Curves.easeInOut,
    this.enableHaptic = true,
  });

  @override
  State<TapFeedback> createState() => _TapFeedbackState();
}

class _TapFeedbackState extends State<TapFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
        _handleTap();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: widget.minScale).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        ),
        child: widget.child,
      ),
    );
  }
}

/// Animated number counter (for calorie displays, etc.)
class AnimatedCounter extends ImplicitlyAnimatedWidget {
  final int value;
  final TextStyle? textStyle;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.textStyle,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
  }) : super(duration: duration, curve: curve);

  @override
  ImplicitlyAnimatedWidgetState<AnimatedCounter> createState() =>
      _AnimatedCounterState();
}

class _AnimatedCounterState extends AnimatedWidgetBaseState<AnimatedCounter> {
  late IntTween _intTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _intTween = visitor(
      _intTween,
      widget.value,
      (dynamic value) => IntTween(begin: value as int),
    )! as IntTween;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _intTween.evaluate(animation).toString(),
      style: widget.textStyle,
    );
  }
}

/// Haptic feedback patterns
class HapticFeedbacks {
  /// Light tap feedback
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium tap feedback
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy tap feedback
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Success pattern (light + light)
  static Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }

  /// Error pattern (medium)
  static Future<void> error() async {
    await HapticFeedback.mediumImpact();
  }

  /// Selection pattern (light)
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }
}

/// Animated icon button with scale effect
class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final Duration animationDuration;
  final double minScale;
  final bool enableHaptic;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24,
    this.animationDuration = const Duration(milliseconds: 200),
    this.minScale = 0.8,
    this.enableHaptic = true,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
        _handleTap();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: widget.minScale)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
        child: Icon(widget.icon, size: widget.size, color: widget.color),
      ),
    );
  }
}

/// Staggered list animation helper
class StaggeredListAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration delayBetween;
  final Duration itemDuration;
  final Offset beginOffset;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.delayBetween = const Duration(milliseconds: 100),
    this.itemDuration = const Duration(milliseconds: 500),
    this.beginOffset = const Offset(0, 0.5),
  });

  @override
  State<StaggeredListAnimation> createState() => _StaggeredListAnimationState();
}

class _StaggeredListAnimationState extends State<StaggeredListAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        duration: widget.itemDuration,
        vsync: this,
      ),
    );

    // Start animations with staggered delays
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.delayBetween * i, () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.children.length,
        (index) => SlideTransition(
          position: Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
              .animate(CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut)),
          child: FadeTransition(
            opacity: _controllers[index],
            child: widget.children[index],
          ),
        ),
      ),
    );
  }
}

/// Pulse animation for attention-grabbing
class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minOpacity;
  final Curve curve;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.minOpacity = 0.5,
    this.curve = Curves.easeInOut,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: widget.minOpacity).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      ),
      child: widget.child,
    );
  }
}

/// Bounce animation for alerts
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int bounces;
  final Curve curve;

  const BounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.bounces = 3,
    this.curve = Curves.elasticInOut,
  });

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      ),
      child: widget.child,
    );
  }
}

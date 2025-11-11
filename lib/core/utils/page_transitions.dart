import 'package:flutter/material.dart';

/// Custom Page Route Transitions
///
/// Provides reusable page transition animations that add polish and
/// visual delight to navigation. Includes zoom, slide, fade, and
/// combined effects with configurable durations and curves.

/// Zoom transition - scales from 0.8 to 1.0
class ZoomPageRoute<T> extends PageRoute<T> {
  ZoomPageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
    super.settings,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      ),
    );
  }
}

/// Slide from bottom transition
class SlideBottomPageRoute<T> extends PageRoute<T> {
  SlideBottomPageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    super.settings,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      ),
    );
  }
}

/// Slide from right transition
class SlideRightPageRoute<T> extends PageRoute<T> {
  SlideRightPageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    super.settings,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }
}

/// Fade transition - simple opacity
class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    super.settings,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }
}

/// Extension for easy navigation with custom transitions
extension PageTransitionNavigation on BuildContext {
  /// Navigate with zoom animation
  Future<T?> pushZoom<T>(
    Widget Function(BuildContext) builder, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    RouteSettings? settings,
  }) {
    return Navigator.of(this).push(
      ZoomPageRoute(
        builder: builder,
        duration: duration,
        curve: curve,
        settings: settings,
      ),
    );
  }

  /// Navigate with slide from bottom animation
  Future<T?> pushSlideBottom<T>(
    Widget Function(BuildContext) builder, {
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    RouteSettings? settings,
  }) {
    return Navigator.of(this).push(
      SlideBottomPageRoute(
        builder: builder,
        duration: duration,
        curve: curve,
        settings: settings,
      ),
    );
  }

  /// Navigate with slide from right animation
  Future<T?> pushSlideRight<T>(
    Widget Function(BuildContext) builder, {
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    RouteSettings? settings,
  }) {
    return Navigator.of(this).push(
      SlideRightPageRoute(
        builder: builder,
        duration: duration,
        curve: curve,
        settings: settings,
      ),
    );
  }

  /// Navigate with fade animation
  Future<T?> pushFade<T>(
    Widget Function(BuildContext) builder, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    RouteSettings? settings,
  }) {
    return Navigator.of(this).push(
      FadePageRoute(
        builder: builder,
        duration: duration,
        curve: curve,
        settings: settings,
      ),
    );
  }
}

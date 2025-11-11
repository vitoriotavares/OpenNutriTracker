import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../styles/design_tokens.dart';

/// Success Animations & Celebration Effects
///
/// Provides visual feedback and celebration animations for successful actions
/// like adding meals, logging activities, reaching goals, etc.

/// Confetti particle animation
class ConfettiPiece {
  late double x;
  late double y;
  late double vx;
  late double vy;
  late Color color;
  late double size;
  late double rotation;
  late double rotationSpeed;

  ConfettiPiece({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

/// Confetti animation widget
class ConfettiAnimation extends StatefulWidget {
  final Duration duration;
  final int particleCount;
  final VoidCallback? onComplete;

  const ConfettiAnimation({
    super.key,
    this.duration = const Duration(milliseconds: 3000),
    this.particleCount = 30,
    this.onComplete,
  });

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<ConfettiPiece> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _initializeParticles();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  void _initializeParticles() {
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];

    _particles = List.generate(widget.particleCount, (index) {
      return ConfettiPiece(
        x: 0.5,
        y: 0.5,
        vx: 0,
        vy: 0,
        color: colors[index % colors.length],
        size: 4 + (index % 5).toDouble(),
        rotation: 0,
        rotationSpeed: (index % 10) * 0.5,
      );
    });

    // Better particle distribution using angle
    for (int i = 0; i < _particles.length; i++) {
      final angle = (i / _particles.length) * 2 * pi;
      final velocity = 300.0 + (i % 3) * 100;
      _particles[i].vx = velocity * 0.001 * cos(angle);
      _particles[i].vy = velocity * 0.001 * sin(angle);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final particles = _particles.map((p) {
          final progress = _controller.value;
          final gravity = 0.5;

          return ConfettiPiece(
            x: p.x + p.vx * progress + 0.05 * progress * progress,
            y: p.y + p.vy * progress + gravity * progress * progress,
            vx: p.vx,
            vy: p.vy,
            color: p.color.withValues(alpha: 1.0 - (progress * 0.3)),
            size: p.size,
            rotation: p.rotation + p.rotationSpeed * progress,
            rotationSpeed: p.rotationSpeed,
          );
        }).toList();

        return CustomPaint(
          painter: ConfettiPainter(particles),
          size: Size.infinite,
        );
      },
    );
  }
}

/// Painter for confetti particles
class ConfettiPainter extends CustomPainter {
  final List<ConfettiPiece> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final x = particle.x * size.width;
      final y = particle.y * size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(particle.rotation);

      final paint = Paint()..color = particle.color;
      canvas.drawRect(
        Rect.fromCenter(
          center: const Offset(0, 0),
          width: particle.size,
          height: particle.size,
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}

/// Success checkmark animation
class SuccessCheckmark extends StatefulWidget {
  final Duration duration;
  final double size;
  final Color? color;
  final VoidCallback? onComplete;

  const SuccessCheckmark({
    super.key,
    this.duration = const Duration(milliseconds: 800),
    this.size = 100,
    this.color,
    this.onComplete,
  });

  @override
  State<SuccessCheckmark> createState() => _SuccessCheckmarkState();
}

class _SuccessCheckmarkState extends State<SuccessCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.elasticOut,
            ),
          ),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circle background
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.1),
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                ),
                // Checkmark
                CustomPaint(
                  painter: CheckmarkPainter(
                    progress: _controller.value,
                    color: color,
                  ),
                  size: Size(widget.size * 0.6, widget.size * 0.6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Painter for checkmark icon
class CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;

  CheckmarkPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw checkmark in two parts: first the left part, then the right
    final path = Path();

    if (progress <= 0.5) {
      // First half: draw left part of checkmark
      final p = progress * 2; // 0 to 1 for first half
      path.moveTo(size.width * 0.3, size.height * 0.55);
      path.lineTo(size.width * 0.3 + (size.width * 0.2) * p, size.height * 0.55 + (size.height * 0.2) * p);
    } else {
      // Second half: draw right part of checkmark
      path.moveTo(size.width * 0.3, size.height * 0.55);
      path.lineTo(size.width * 0.5, size.height * 0.75);

      final p = (progress - 0.5) * 2; // 0 to 1 for second half
      path.lineTo(
        size.width * 0.5 + (size.width * 0.5) * p,
        size.height * 0.75 - (size.height * 0.45) * p,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Full screen success overlay with celebration
class SuccessOverlay extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismiss;
  final bool showConfetti;
  final IconData icon;

  const SuccessOverlay({
    super.key,
    required this.message,
    required this.onDismiss,
    this.duration = const Duration(milliseconds: 3000),
    this.showConfetti = true,
    this.icon = Icons.check_circle,
  });

  @override
  State<SuccessOverlay> createState() => _SuccessOverlayState();
}

class _SuccessOverlayState extends State<SuccessOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    // Trigger haptic feedback
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) HapticFeedback.lightImpact();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0)
          .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1.0))),
      child: SlideTransition(
        position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.5))
            .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0))),
        child: Stack(
          children: [
            // Confetti
            if (widget.showConfetti)
              ConfettiAnimation(
                duration: const Duration(milliseconds: 2000),
                particleCount: 50,
              ),
            // Success message
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.message,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Success dialog with haptic and animation
class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;
  final IconData icon;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
    this.icon = Icons.check_circle,
  });

  @override
  Widget build(BuildContext context) {
    // Trigger haptic feedback on build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HapticFeedback.heavyImpact();
    });

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ONTDesignTokens.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: AlwaysStoppedAnimation(1.0),
              child: BounceAnimation(
                child: Icon(
                  icon,
                  size: 80,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onAction?.call();
                  Navigator.pop(context);
                },
                child: Text(actionText ?? 'Great!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bounce animation helper
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const BounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
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
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
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
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      ),
      child: widget.child,
    );
  }
}

/// Helper extension for showing success animations
extension SuccessAnimationHelper on BuildContext {
  /// Show a quick success toast
  void showSuccessToast(String message, {Duration duration = const Duration(seconds: 2)}) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success dialog
  Future<void> showSuccessDialog({
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return showDialog(
      context: this,
      builder: (context) => SuccessDialog(
        title: title,
        message: message,
        actionText: actionText,
        onAction: onAction,
      ),
    );
  }
}

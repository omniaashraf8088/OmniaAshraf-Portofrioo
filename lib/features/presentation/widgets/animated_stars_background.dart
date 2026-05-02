import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedStarsBackground extends StatefulWidget {
  final Widget child;

  const AnimatedStarsBackground({super.key, required this.child});

  @override
  State<AnimatedStarsBackground> createState() =>
      _AnimatedStarsBackgroundState();
}

class _AnimatedStarsBackgroundState extends State<AnimatedStarsBackground>
    with TickerProviderStateMixin {
  late AnimationController _twinkleController;
  late AnimationController _moveController;
  final List<Star> _stars = [];
  final int _starCount = 100;

  @override
  void initState() {
    super.initState();

    // Twinkle animation - slow and smooth with varied phases
    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Movement animation - smooth continuous drift
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    // Generate random stars
    final random = Random();
    for (int i = 0; i < _starCount; i++) {
      _stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 2.5 + 1.5,
        opacity: random.nextDouble() * 0.5 + 0.3,
        twinkleSpeed: random.nextDouble() * 1.2 + 0.5,
        moveSpeed: random.nextDouble() * 0.4 + 0.15,
        moveDirection: random.nextDouble() * 2 * pi,
        twinklePhase: random.nextDouble() * 2 * pi,
      ));
    }
  }

  @override
  void dispose() {
    _twinkleController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [
                      const Color(0xFF0D1B2A),
                      const Color(0xFF1B263B),
                    ]
                  : [
                      Colors.white,
                      const Color(0xFFF8F9FA),
                    ],
            ),
          ),
        ),
        // Stars animation layer
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _twinkleController,
            builder: (context, child) {
              return AnimatedBuilder(
                animation: _moveController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: StarsPainter(
                      stars: _stars,
                      twinkleValue: _twinkleController.value,
                      moveValue: _moveController.value,
                      isDarkMode:
                          Theme.of(context).brightness == Brightness.dark,
                    ),
                  );
                },
              );
            },
          ),
        ),
        // Content
        widget.child,
      ],
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double twinkleSpeed;
  final double moveSpeed;
  final double moveDirection;
  final double twinklePhase;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
    required this.moveSpeed,
    required this.moveDirection,
    required this.twinklePhase,
  });
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double twinkleValue;
  final double moveValue;
  final bool isDarkMode;

  StarsPainter({
    required this.stars,
    required this.twinkleValue,
    required this.moveValue,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      // Calculate smooth twinkle effect with cubic easing for natural pulsing
      final twinklePhase =
          (twinkleValue * star.twinkleSpeed * 2 * pi) + star.twinklePhase;
      final rawTwinkle = (sin(twinklePhase) + 1) / 2;
      // Apply cubic easing for smoother, more organic twinkling
      final twinkle = rawTwinkle * rawTwinkle * (3 - 2 * rawTwinkle);
      final currentOpacity = star.opacity * (0.2 + 0.8 * twinkle);

      // Calculate smooth circular movement with easing
      final movePhase = moveValue * star.moveSpeed * 2 * pi;
      final moveX = cos(star.moveDirection + movePhase) * 20;
      final moveY = sin(star.moveDirection + movePhase) * 20;

      // Star colors - beautiful pink gradient
      final Color starColor = isDarkMode
          ? Color.lerp(
              const Color(0xFFFF69B4), // Hot Pink
              const Color(0xFFFFB6C1), // Light Pink
              twinkle,
            )!
          : Color.lerp(
              const Color(0xFFFF1493), // Deep Pink
              const Color(0xFFFF69B4), // Hot Pink
              twinkle,
            )!;

      // Calculate position with movement
      final dx = (star.x * size.width + moveX) % size.width;
      final dy = (star.y * size.height + moveY) % size.height;

      // Draw outer glow (largest, most transparent)
      final glowPaint1 = Paint()
        ..style = PaintingStyle.fill
        ..color = starColor.withValues(alpha: currentOpacity * 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(dx, dy), star.size * 6, glowPaint1);

      // Draw middle glow
      final glowPaint2 = Paint()
        ..style = PaintingStyle.fill
        ..color = starColor.withValues(alpha: currentOpacity * 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(dx, dy), star.size * 3, glowPaint2);

      // Draw inner glow
      final glowPaint3 = Paint()
        ..style = PaintingStyle.fill
        ..color = starColor.withValues(alpha: currentOpacity * 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(Offset(dx, dy), star.size * 1.5, glowPaint3);

      // Draw the star shape
      final starPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = starColor.withValues(alpha: currentOpacity);
      _drawStar(canvas, Offset(dx, dy), star.size * 1.2, starPaint);

      // Add bright white center point
      final centerPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white.withValues(alpha: currentOpacity * 0.9);
      canvas.drawCircle(Offset(dx, dy), star.size * 0.3, centerPaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const int points = 4; // 4-pointed star for a sparkle effect
    const double angle = (2 * pi) / points;

    for (int i = 0; i < points; i++) {
      // Outer point
      final outerX = center.dx + radius * cos(i * angle - pi / 2);
      final outerY = center.dy + radius * sin(i * angle - pi / 2);

      // Inner point
      final innerX =
          center.dx + (radius * 0.3) * cos(i * angle + angle / 2 - pi / 2);
      final innerY =
          center.dy + (radius * 0.3) * sin(i * angle + angle / 2 - pi / 2);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => true;
}

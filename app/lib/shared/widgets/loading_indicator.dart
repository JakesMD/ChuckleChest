import 'package:flutter/material.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CCradleLoadingIndicator}
///
/// A widget that displays an animated, linear newtons cradle with 3 balls as a
/// loading indicator.
///
/// {@endtemplate}
class CCradleLoadingIndicator extends StatefulWidget {
  /// {@macro CCradleLoadingIndicator}
  const CCradleLoadingIndicator({super.key, this.ballSize = 12, this.color});

  /// The size of the balls.
  final double ballSize;

  /// The color of the balls.
  final Color? color;

  @override
  State<CCradleLoadingIndicator> createState() =>
      _CCradleLoadingIndicatorState();
}

class _CCradleLoadingIndicatorState extends State<CCradleLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController leftBallController;
  late AnimationController rightBallController;
  late Animation<double> leftBallAnimation;
  late Animation<double> rightBallAnimation;

  Color? ballColor;

  @override
  void initState() {
    super.initState();

    leftBallController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    rightBallController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    leftBallAnimation = Tween<double>(
      begin: 0,
      end: -widget.ballSize * 2,
    ).animate(
      CurvedAnimation(parent: leftBallController, curve: Curves.easeOutSine),
    );
    rightBallAnimation = Tween<double>(
      begin: 0,
      end: widget.ballSize * 2,
    ).animate(
      CurvedAnimation(parent: rightBallController, curve: Curves.easeOutSine),
    );

    leftBallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        leftBallController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        rightBallController.forward();
      }
    });

    rightBallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rightBallController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        leftBallController.forward();
      }
    });

    leftBallController.forward();
  }

  @override
  void dispose() {
    leftBallController.dispose();
    rightBallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ballColor ??= widget.color ?? Theme.of(context).colorScheme.primary;

    return SignedSpacingRow(
      spacing: widget.ballSize / 3,
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        AnimatedBuilder(
          animation: leftBallController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(leftBallAnimation.value, 0),
              child: _CCradleBall(size: widget.ballSize, color: ballColor!),
            );
          },
        ),
        _CCradleBall(size: widget.ballSize, color: ballColor!),
        AnimatedBuilder(
          animation: rightBallController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(rightBallAnimation.value, 0),
              child: _CCradleBall(size: widget.ballSize, color: ballColor!),
            );
          },
        ),
      ],
    );
  }
}

/// {@template CBouncyBallLoadingIndicator}
///
/// A widget that displays an animated bouncing ball as a loading indicator.
///
/// {@endtemplate}
class CBouncyBallLoadingIndicator extends StatefulWidget {
  /// {@macro CBouncyBallLoadingIndicator}
  const CBouncyBallLoadingIndicator({
    super.key,
    this.ballSize = 12,
    this.color,
  });

  /// The size of the balls.
  final double ballSize;

  /// The color of the balls.
  final Color? color;

  @override
  State<CBouncyBallLoadingIndicator> createState() =>
      _CBouncyBallLoadingIndicatorState();
}

class _CBouncyBallLoadingIndicatorState
    extends State<CBouncyBallLoadingIndicator> with TickerProviderStateMixin {
  late AnimationController ballController;
  late Animation<double> ballAnimation;

  Color? ballColor;

  @override
  void initState() {
    super.initState();

    ballController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    ballAnimation = Tween<double>(
      begin: widget.ballSize * 1.5,
      end: -widget.ballSize * 1.5,
    ).animate(
      CurvedAnimation(parent: ballController, curve: Curves.easeOutSine),
    );

    ballController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ballController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          ballController.forward();
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    ballController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ballColor ??= widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: ballController,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, ballAnimation.value),
        child: _CCradleBall(size: widget.ballSize, color: ballColor!),
      ),
    );
  }
}

class _CCradleBall extends StatelessWidget {
  const _CCradleBall({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CCradleBallPainter(color: color),
    );
  }
}

class _CCradleBallPainter extends CustomPainter {
  const _CCradleBallPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

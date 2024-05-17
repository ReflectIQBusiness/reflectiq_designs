import 'package:flutter/material.dart';

class ThreeShimmerArrows extends StatefulWidget {
  const ThreeShimmerArrows({super.key});

  @override
  _ThreeShimmerArrowsState createState() => _ThreeShimmerArrowsState();
}

class _ThreeShimmerArrowsState extends State<ThreeShimmerArrows> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShimmerArrow(
          animation: _controller,
        ),
        SizedBox(height: 20),
        ShimmerArrow(
          animation: _controller,
        ),
        SizedBox(height: 20),
        ShimmerArrow(
          animation: _controller,
        ),
      ],
    );
  }
}

class ShimmerArrow extends StatelessWidget {
  final Animation<double> animation;

  ShimmerArrow({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            double shimmerPosition = ((animation.value) % 1.0);
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                shimmerPosition - 0.3,
                shimmerPosition,
                shimmerPosition + 0.3,
              ],
              colors: [
                Colors.grey,
                Colors.white,
                Colors.grey,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: ArrowWidget(),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height * 0.5); // Start point at the middle right
    path.lineTo(size.width * 0.25, 0); // Top-left point
    path.lineTo(0, size.height * 0.25); // Left point
    path.lineTo(size.width * 0.5, size.height * 0.5); // Middle point
    path.lineTo(0, size.height * 0.75); // Bottom-left point
    path.lineTo(size.width * 0.25, size.height); // Bottom-right point
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ArrowWidget extends StatelessWidget {
  const ArrowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(15, 20), // Adjust the size of the arrow as needed
      painter: ArrowPainter(),
    );
  }
}

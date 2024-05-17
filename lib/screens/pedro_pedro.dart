import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class PedroPedroTrend extends StatefulWidget {
  const PedroPedroTrend({super.key});

  @override
  State<PedroPedroTrend> createState() => _PedroPedroTrendState();
}

class _PedroPedroTrendState extends State<PedroPedroTrend> with TickerProviderStateMixin {
  AnimationController? rotationController;
  AnimationController? bounceController;
  Animation<double>? bounceAnimation;

  @override
  void initState() {
    super.initState();

    rotationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    bounceAnimation = Tween(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: bounceController!,
        curve: Curves.bounceInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bounceController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          bounceController!.forward();
        }
      });

    bounceController!.forward();
  }

  @override
  void dispose() {
    rotationController?.dispose();
    bounceController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Pedro Pedro Trend, in a different way! 🚀",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [
                  Color.fromARGB(255, 239, 209, 175),
                  Color.fromARGB(213, 246, 189, 109),
                ],
                stops: [0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: OverflowBox(
              maxHeight: 300, //
              child: AnimatedBuilder(
                animation: Listenable.merge([rotationController, bounceAnimation]),
                child: Image.asset(
                  'assets/pedro.png',
                  height: 320, // Image is slightly larger
                  width: 320,
                  fit: BoxFit.contain,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: rotationController!.value * 2.0 * math.pi,
                    child: Transform.scale(scale: bounceAnimation!.value, child: child!),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..repeat();
    nextScreen();
  }

  void nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).pushReplacementNamed('introduce');
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
                angle: animationController.value * 1.5 * math.pi,
                child: SvgPicture.asset(
                  'assets/icons/flower.svg',
                  fit: BoxFit.cover,
                ));
          },
        ),
      ),
    );
  }
}

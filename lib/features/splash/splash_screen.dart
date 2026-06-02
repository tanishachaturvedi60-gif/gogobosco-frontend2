import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Animated container/scale for premium entry
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
                builder: (context, val, child) {
                  return Transform.scale(
                    scale: val,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/ggbLogo.png',
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "GoGoBosco",
                style: TextStyle(
                  color: AppTheme.primaryRed,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your Gateway to Opportunities",
                style: TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const DotLoader(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class DotLoader extends StatefulWidget {
  const DotLoader({super.key});

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildDot(double delay, Color color) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = (controller.value - delay);
        value = value < 0 ? value + 1 : value;

        double translateY = -12 * (0.5 - (value - 0.5).abs());

        return Transform.translate(offset: Offset(0, translateY), child: child);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDot(0.0, AppTheme.primaryRed),
        buildDot(0.2, AppTheme.accentYellow),
        buildDot(0.4, AppTheme.primaryRed),
      ],
    );
  }
}


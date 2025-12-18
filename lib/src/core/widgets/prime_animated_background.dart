import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

/// A premium animated background widget with a subtle deep gradient shift.
/// Designed for Login, Splash, and Dashboard backgrounds.
///
/// Usage:
/// ```dart
/// Scaffold(
///   body: PrimeAnimatedBackground(
///     child: Center(child: Text("Content")),
///   ),
/// )
/// ```
class PrimeAnimatedBackground extends StatelessWidget {
  final Widget child;
  final bool enableAnimation;

  const PrimeAnimatedBackground({
    super.key,
    required this.child,
    this.enableAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableAnimation) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDark, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      );
    }

    // We use flutter_animate to create a continuous gradient loop.
    // By animating the alignment, we get a subtle "shifting light" effect
    // without the heavy cost of some shader implementations.
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: AppColors.primaryDark),
      child: Stack(
        children: [
          // Layer 1: Deep Blue Base Shift
          Animate(
            onPlay: (controller) => controller.repeat(reverse: true),
            effects: [
              CustomEffect(
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [
                          AppColors.primaryDark, // Slate 950
                          Color(0xFF0F172A),     // Slate 900
                          Color(0xFF1E293B),     // Slate 800
                        ],
                        begin: Alignment(-1.0 + value, -1.0),
                        end: Alignment(1.0 - value, 1.0),
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  );
                },
                duration: 10.seconds,
                curve: Curves.easeInOut,
              )
            ],
          ),
          
          // Layer 2: Subtle Accent Glow (Top Right)
          // Adds a tiny hint of the brand orange in the dark, very subtle.
          Positioned(
            top: -100,
            right: -100,
            child: Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
              effects: const [
                ScaleEffect(
                  begin: Offset(1.0, 1.0),
                  end: Offset(1.5, 1.5),
                  duration: Duration(seconds: 15),
                ),
                FadeEffect(begin: 0.1, end: 0.2, duration: Duration(seconds: 8)),
              ],
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Layer 3: Subtle Cool Glow (Bottom Left)
          Positioned(
            bottom: -150,
            left: -100,
            child: Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
              effects: const [
                ScaleEffect(
                  begin: Offset(1.2, 1.2),
                  end: Offset(1.0, 1.0),
                  duration: Duration(seconds: 12),
                ),
                FadeEffect(begin: 0.05, end: 0.15, duration: Duration(seconds: 10)),
              ],
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(child: child),
        ],
      ),
    );
  }
}

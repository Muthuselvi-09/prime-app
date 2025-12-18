import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors (Trust, Professionalism)
  static const Color primary = Color(0xFF0F172A); // Slate 900
  static const Color primaryDark = Color(0xFF020617); // Slate 950
  static const Color primaryLight = Color(0xFF334155); // Slate 700

  // Accent Colors (Safety Identity - Construction Orange)
  static const Color accent = Color(0xFFFF6D00); // Vivid Orange
  static const Color accentDark = Color(0xFFE65100);
  static const Color accentLight = Color(0xFFFF9E40);

  // Background Colors
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B); // For Dark Mode

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B); // Slate 800
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textInverse = Color(0xFFF1F5F9); // Slate 100 white-ish

  // Functional Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color info = Color(0xFF3B82F6); // Blue 500

  // Border & Divider
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color divider = Color(0xFFF1F5F9); // Slate 100

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

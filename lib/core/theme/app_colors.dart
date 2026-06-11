import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Colors
  static const Color primaryColor = Color(0xFF10B981);
  static const Color primaryGradientEnd = Color(0xFF10B981);
  static const Color secondaryColor = Color(0xFF10B981);


  // Neutrals
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFF10B981);
  static const Color info = Color(0xFF3B82F6);

  // Light Surfaces
  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Dark Surfaces
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);

  // Light Text
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Text
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Shimmer & Generic Surfaces
  static const Color surface = Color(0xFFE5E7EB);
  static const Color shimmerBase = Color(0xFFE5E7EB);
  static const Color shimmerHighlight = Color(0xFFF3F4F6);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';

abstract class AppTextStyles {
  // Light Regular Styles
  static TextStyle displayLarge = GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle headlineLarge = GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle headlineMedium = GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle titleLarge = GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle titleMedium = GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle bodyLarge = GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle bodyMedium = GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary);
  static TextStyle bodySmall = GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary);
  static TextStyle labelLarge = GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary);
  static TextStyle labelSmall = GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary);

  // Light Bold Styles
  static TextStyle displayLargeBold = displayLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle headlineLargeBold = headlineLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle headlineMediumBold = headlineMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle titleLargeBold = titleLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle titleMediumBold = titleMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle bodyLargeBold = bodyLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle bodyMediumBold = bodyMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle bodySmallBold = bodySmall.copyWith(fontWeight: FontWeight.bold);
  static TextStyle labelLargeBold = labelLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle labelSmallBold = labelSmall.copyWith(fontWeight: FontWeight.bold);

  // Dark Regular Styles
  static TextStyle darkDisplayLarge = displayLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkHeadlineLarge = headlineLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkHeadlineMedium = headlineMedium.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkTitleLarge = titleLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkTitleMedium = titleMedium.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkBodyLarge = bodyLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkBodyMedium = bodyMedium.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle darkBodySmall = bodySmall.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle darkLabelLarge = labelLarge.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle darkLabelSmall = labelSmall.copyWith(color: AppColors.darkTextSecondary);

  // Dark Bold Styles
  static TextStyle darkDisplayLargeBold = darkDisplayLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkHeadlineLargeBold = darkHeadlineLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkHeadlineMediumBold = darkHeadlineMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkTitleLargeBold = darkTitleLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkTitleMediumBold = darkTitleMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkBodyLargeBold = darkBodyLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkBodyMediumBold = darkBodyMedium.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkBodySmallBold = darkBodySmall.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkLabelLargeBold = darkLabelLarge.copyWith(fontWeight: FontWeight.bold);
  static TextStyle darkLabelSmallBold = darkLabelSmall.copyWith(fontWeight: FontWeight.bold);
}

import 'package:flutter/material.dart';
import 'package:quran_app/common/themes/app_colors.dart';
import 'package:quran_app/common/themes/text_styles.dart';

class TextThemes {
  /// Main text theme
  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.bodyMd,
      bodySmall: AppTextStyles.bodySm,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
      titleLarge: AppTextStyles.h3,
      titleMedium: AppTextStyles.h4,
      titleSmall: AppTextStyles.h5,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineLarge: AppTextStyles.h4,
      headlineMedium: AppTextStyles.h5,
      headlineSmall: AppTextStyles.h6,
    );
  }

  /// Dark text theme
  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.bodyMd.copyWith(color: AppColors.white),
      bodySmall: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.white),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.white),
      titleLarge: AppTextStyles.h3.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.h4.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.h5.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.white),
      headlineLarge: AppTextStyles.h4.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.h5.copyWith(color: AppColors.white),
      headlineSmall: AppTextStyles.h6.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme
  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.primary),
      bodyMedium: AppTextStyles.bodyMd.copyWith(color: AppColors.primary),
      bodySmall: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
      titleLarge: AppTextStyles.h3.copyWith(color: AppColors.primary),
      titleMedium: AppTextStyles.h4.copyWith(color: AppColors.primary),
      titleSmall: AppTextStyles.h5.copyWith(color: AppColors.primary),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.primary),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.primary),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.primary),
      headlineLarge: AppTextStyles.h4.copyWith(color: AppColors.primary),
      headlineMedium: AppTextStyles.h5.copyWith(color: AppColors.primary),
      headlineSmall: AppTextStyles.h6.copyWith(color: AppColors.primary),
    );
  }
}

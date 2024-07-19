import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/local_data/theme_local_data.dart';
import 'package:quran_app/common/themes/app_colors.dart';
import 'package:quran_app/common/themes/text_styles.dart';
import 'package:quran_app/common/themes/text_theme.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit(this.themeStorage) : super(ThemeMode.light) {
    getCurrentTheme();
  }

  final ThemeLocalData themeStorage;
  ThemeMode currentTheme = ThemeMode.light;

  Future<void> getCurrentTheme() async {
    final theme = await themeStorage.getValue();
    final value = ThemeMode.values.byName(theme ?? 'light');
    emit(value);
  }

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    themeStorage.setValue(state.name);
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.white,
        error: AppColors.error,
        surface: AppColors.black,
        onSurface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.h2,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.white,
        error: AppColors.error,
        surface: AppColors.white,
        onSurface: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        titleTextStyle: AppTextStyles.h2,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
    );
  }
}

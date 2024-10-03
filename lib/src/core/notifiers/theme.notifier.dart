// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../configs/themes/app_colors.dart';

class AppTheme {
  // Base Theme
  static ThemeData get baseTheme {
    return ThemeData(
      fontFamily: 'Roboto', // You can set a default font family here
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        primaryContainer: AppColors.lightPrimaryVariant,
        secondary: AppColors.lightSecondary,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onPrimary: AppColors.lightOnPrimary,
        onSecondary: AppColors.lightOnSecondary,
        onSurface: AppColors.lightOnSurface,
        onError: AppColors.lightOnError,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        primaryContainer: AppColors.darkPrimaryVariant,
        secondary: AppColors.darkSecondary,
        surface: AppColors.darkSurface,
        error: AppColors.darkError,
        onPrimary: AppColors.darkOnPrimary,
        onSecondary: AppColors.darkOnSecondary,
        onSurface: AppColors.darkOnSurface,
        onError: AppColors.darkOnError,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }
}

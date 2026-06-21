import 'package:flutter/material.dart';

/// Semantic color palette inspired by Apple Human Interface Guidelines (HIG).
///
/// Use [AppColors.of(context)] to access active theme-specific colors.
class AppColors {
  AppColors._();

  // --- BRAND / BASE PALETTE ---

  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF007AFF); // iOS Blue
  static const Color lightSecondary = Color(0xFF5856D6); // iOS Purple
  static const Color lightBackground = Color(
    0xFFF2F2F7,
  ); // System Grouped Background
  static const Color lightSurface = Color(
    0xFFFFFFFF,
  ); // Card/Surface Background
  static const Color lightTranslucentSurface = Color(
    0xCCFFFFFF,
  ); // 80% Translucent White
  static const Color lightTextPrimary = Color(0xFF000000); // Primary Label
  static const Color lightTextSecondary = Color(
    0x993C3C43,
  ); // Secondary Label (60% Opacity)
  static const Color lightTextTertiary = Color(
    0x4D3C3C43,
  ); // Tertiary Label (30% Opacity)
  static const Color lightBorder = Color(0xFFC6C6C8); // Opaque Separator
  static const Color lightError = Color(0xFFFF3B30); // iOS Red
  static const Color lightSuccess = Color(0xFF34C759); // iOS Green
  static const Color lightWarning = Color(0xFFFF9500); // iOS Orange

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF0A84FF); // iOS Dark Blue
  static const Color darkSecondary = Color(0xFF5E5CE6); // iOS Dark Purple
  static const Color darkBackground = Color(
    0xFF000000,
  ); // Dark System Background
  static const Color darkSurface = Color(
    0xFF1C1C1E,
  ); // Dark Card/Surface Background
  static const Color darkTranslucentSurface = Color(
    0xCC1C1C1E,
  ); // 80% Translucent Dark Grey
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // Dark Primary Label
  static const Color darkTextSecondary = Color(
    0x99EBEBF5,
  ); // Dark Secondary Label (60% Opacity)
  static const Color darkTextTertiary = Color(
    0x4DEBEBF5,
  ); // Dark Tertiary Label (30% Opacity)
  static const Color darkBorder = Color(0xFF38383A); // Dark Opaque Separator
  static const Color darkError = Color(0xFFFF453A); // iOS Dark Red
  static const Color darkSuccess = Color(0xFF30D158); // iOS Dark Green
  static const Color darkWarning = Color(0xFFFF9F0A); // iOS Dark Orange

  // Static constants for general use
  static const Color primary = lightPrimary;
  static const Color secondary = lightSecondary;
  static const Color error = lightError;
  static const Color success = lightSuccess;
  static const Color warning = lightWarning;

  /// Helper method to retrieve semantic theme colors from the build context.
  static AppThemeColors of(BuildContext context) {
    final extension = Theme.of(context).extension<AppThemeColors>();
    assert(extension != null, 'No AppThemeColors found in context theme.');
    return extension!;
  }
}

/// ThemeExtension for semantic colors to support clean Dark & Light mode switches.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color translucentSurface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color error;
  final Color success;
  final Color warning;

  const AppThemeColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.translucentSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.error,
    required this.success,
    required this.warning,
  });

  static const light = AppThemeColors(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    translucentSurface: AppColors.lightTranslucentSurface,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    border: AppColors.lightBorder,
    error: AppColors.lightError,
    success: AppColors.lightSuccess,
    warning: AppColors.lightWarning,
  );

  static const dark = AppThemeColors(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    translucentSurface: AppColors.darkTranslucentSurface,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    border: AppColors.darkBorder,
    error: AppColors.darkError,
    success: AppColors.darkSuccess,
    warning: AppColors.darkWarning,
  );

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? translucentSurface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? border,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      translucentSurface: translucentSurface ?? this.translucentSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      border: border ?? this.border,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      translucentSurface: Color.lerp(
        translucentSurface,
        other.translucentSurface,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

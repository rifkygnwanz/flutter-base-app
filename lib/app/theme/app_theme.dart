import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Central theme configuration for the application.
class AppTheme {
  AppTheme._();

  /// Light Theme configuration mapping standard Material/Cupertino properties.
  static ThemeData get light {
    final colors = AppThemeColors.light;
    final typography = AppThemeTypography.create(
      textColor: colors.textPrimary,
      secondaryColor: colors.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.surface,
      dividerColor: colors.border,
      splashFactory: NoSplash.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        error: colors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: colors.textPrimary,
        onError: Colors.white,
      ),

      // AppBar theme setup
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: colors.border,
        iconTheme: IconThemeData(color: colors.primary),
        titleTextStyle: typography.headline,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Card theme setup
      cardTheme: const CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
      ),

      // Divider theme setup
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 0.5,
        space: AppSpacing.md,
      ),

      // Input configuration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: AppSpacing.edgeInsetsSymmetricMd,
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.primary, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.error, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.error, width: 1.0),
        ),
        labelStyle: typography.body.copyWith(color: colors.textSecondary),
        hintStyle: typography.body.copyWith(color: colors.textTertiary),
        errorStyle: typography.caption.copyWith(color: colors.error),
      ),

      // Register custom HIG extension configurations
      extensions: [colors, typography],
    );
  }

  /// Dark Theme configuration mapping standard Material/Cupertino properties.
  static ThemeData get dark {
    final colors = AppThemeColors.dark;
    final typography = AppThemeTypography.create(
      textColor: colors.textPrimary,
      secondaryColor: colors.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.surface,
      dividerColor: colors.border,
      splashFactory: NoSplash.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        error: colors.error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: colors.textPrimary,
        onError: Colors.black,
      ),

      // AppBar theme setup
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: colors.border,
        iconTheme: IconThemeData(color: colors.primary),
        titleTextStyle: typography.headline,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card theme setup
      cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
      ),

      // Divider theme setup
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 0.5,
        space: AppSpacing.md,
      ),

      // Input configuration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: AppSpacing.edgeInsetsSymmetricMd,
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.primary, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.error, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: BorderSide(color: colors.error, width: 1.0),
        ),
        labelStyle: typography.body.copyWith(color: colors.textSecondary),
        hintStyle: typography.body.copyWith(color: colors.textTertiary),
        errorStyle: typography.caption.copyWith(color: colors.error),
      ),

      // Register custom HIG extension configurations
      extensions: [colors, typography],
    );
  }
}

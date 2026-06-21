import 'package:flutter/material.dart';

/// Typography configuration mapping directly to Apple Cupertino HIG text styles.
class AppTypography {
  AppTypography._();

  static const String? _fontFamily =
      null; // Uses SF Pro on iOS/macOS, Roboto on Android

  static const TextStyle largeTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 34.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.37,
    height: 1.2,
  );

  static const TextStyle title1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.36,
    height: 1.25,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.35,
    height: 1.3,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17.0,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.41,
    height: 1.35,
  );

  static const TextStyle callout = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.32,
    height: 1.35,
  );

  static const TextStyle subheadline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.24,
    height: 1.35,
  );

  static const TextStyle footnote = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.08,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.0,
    height: 1.4,
  );

  /// Helper method to retrieve semantic typography from the context.
  static AppThemeTypography of(BuildContext context) {
    final extension = Theme.of(context).extension<AppThemeTypography>();
    assert(extension != null, 'No AppThemeTypography found in context theme.');
    return extension!;
  }
}

/// ThemeExtension for iOS typography.
class AppThemeTypography extends ThemeExtension<AppThemeTypography> {
  final TextStyle largeTitle;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle headline;
  final TextStyle body;
  final TextStyle callout;
  final TextStyle subheadline;
  final TextStyle footnote;
  final TextStyle caption;

  const AppThemeTypography({
    required this.largeTitle,
    required this.title1,
    required this.title2,
    required this.headline,
    required this.body,
    required this.callout,
    required this.subheadline,
    required this.footnote,
    required this.caption,
  });

  /// Factory helper that automatically binds the correct text colors based on the theme.
  factory AppThemeTypography.create({
    required Color textColor,
    required Color secondaryColor,
  }) {
    return AppThemeTypography(
      largeTitle: AppTypography.largeTitle.copyWith(color: textColor),
      title1: AppTypography.title1.copyWith(color: textColor),
      title2: AppTypography.title2.copyWith(color: textColor),
      headline: AppTypography.headline.copyWith(color: textColor),
      body: AppTypography.body.copyWith(color: textColor),
      callout: AppTypography.callout.copyWith(color: textColor),
      subheadline: AppTypography.subheadline.copyWith(color: secondaryColor),
      footnote: AppTypography.footnote.copyWith(color: secondaryColor),
      caption: AppTypography.caption.copyWith(color: secondaryColor),
    );
  }

  @override
  AppThemeTypography copyWith({
    TextStyle? largeTitle,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? subheadline,
    TextStyle? footnote,
    TextStyle? caption,
  }) {
    return AppThemeTypography(
      largeTitle: largeTitle ?? this.largeTitle,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subheadline: subheadline ?? this.subheadline,
      footnote: footnote ?? this.footnote,
      caption: caption ?? this.caption,
    );
  }

  @override
  AppThemeTypography lerp(ThemeExtension<AppThemeTypography>? other, double t) {
    if (other is! AppThemeTypography) return this;
    return AppThemeTypography(
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t)!,
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      callout: TextStyle.lerp(callout, other.callout, t)!,
      subheadline: TextStyle.lerp(subheadline, other.subheadline, t)!,
      footnote: TextStyle.lerp(footnote, other.footnote, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}

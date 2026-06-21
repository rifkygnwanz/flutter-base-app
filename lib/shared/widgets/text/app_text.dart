import 'package:flutter/widgets.dart';
import '../../../core/theme/app_typography.dart';

/// Cupertino-inspired typography variant enum.
enum AppTextVariant {
  largeTitle,
  title1,
  title2,
  headline,
  body,
  callout,
  subheadline,
  footnote,
  caption,
}

/// Centralized Typography Component following Cupertino HIG.
class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softWrap;
  final FontWeight? fontWeight;
  final double? height;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  });

  // Short-hand helper constructors for Cupertino hierarchy

  const AppText.largeTitle(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.largeTitle;

  const AppText.title1(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.title1;

  const AppText.title2(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.title2;

  const AppText.headline(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.headline;

  const AppText.body(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.body;

  const AppText.callout(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.callout;

  const AppText.subheadline(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.subheadline;

  const AppText.footnote(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.footnote;

  const AppText.caption(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.fontWeight,
    this.height,
  }) : variant = AppTextVariant.caption;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTypography.of(context);

    TextStyle baseStyle;
    switch (variant) {
      case AppTextVariant.largeTitle:
        baseStyle = textTheme.largeTitle;
        break;
      case AppTextVariant.title1:
        baseStyle = textTheme.title1;
        break;
      case AppTextVariant.title2:
        baseStyle = textTheme.title2;
        break;
      case AppTextVariant.headline:
        baseStyle = textTheme.headline;
        break;
      case AppTextVariant.body:
        baseStyle = textTheme.body;
        break;
      case AppTextVariant.callout:
        baseStyle = textTheme.callout;
        break;
      case AppTextVariant.subheadline:
        baseStyle = textTheme.subheadline;
        break;
      case AppTextVariant.footnote:
        baseStyle = textTheme.footnote;
        break;
      case AppTextVariant.caption:
        baseStyle = textTheme.caption;
        break;
    }

    TextStyle finalStyle = baseStyle;
    if (color != null || fontWeight != null || height != null) {
      finalStyle = baseStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      );
    }

    return Text(
      text,
      style: finalStyle,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}

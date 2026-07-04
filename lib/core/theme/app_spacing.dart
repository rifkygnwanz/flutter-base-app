import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;

  static const double sm = 8.0;

  static const double mdSm = 12.0;

  static const double md = 16.0;

  static const double lg = 24.0;

  static const double xl = 32.0;

  static const double xxl = 48.0;

  static const EdgeInsets edgeInsetsXs = EdgeInsets.all(xs);
  static const EdgeInsets edgeInsetsSm = EdgeInsets.all(sm);
  static const EdgeInsets edgeInsetsMdSm = EdgeInsets.all(mdSm);
  static const EdgeInsets edgeInsetsMd = EdgeInsets.all(md);
  static const EdgeInsets edgeInsetsLg = EdgeInsets.all(lg);
  static const EdgeInsets edgeInsetsXl = EdgeInsets.all(xl);

  static const EdgeInsets edgeInsetsHorizontalXs = EdgeInsets.symmetric(
    horizontal: xs,
  );
  static const EdgeInsets edgeInsetsHorizontalSm = EdgeInsets.symmetric(
    horizontal: sm,
  );
  static const EdgeInsets edgeInsetsHorizontalMdSm = EdgeInsets.symmetric(
    horizontal: mdSm,
  );
  static const EdgeInsets edgeInsetsHorizontalMd = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets edgeInsetsHorizontalLg = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets edgeInsetsHorizontalXl = EdgeInsets.symmetric(
    horizontal: xl,
  );

  static const EdgeInsets edgeInsetsVerticalXs = EdgeInsets.symmetric(
    vertical: xs,
  );
  static const EdgeInsets edgeInsetsVerticalSm = EdgeInsets.symmetric(
    vertical: sm,
  );
  static const EdgeInsets edgeInsetsVerticalMdSm = EdgeInsets.symmetric(
    vertical: mdSm,
  );
  static const EdgeInsets edgeInsetsVerticalMd = EdgeInsets.symmetric(
    vertical: md,
  );
  static const EdgeInsets edgeInsetsVerticalLg = EdgeInsets.symmetric(
    vertical: lg,
  );
  static const EdgeInsets edgeInsetsVerticalXl = EdgeInsets.symmetric(
    vertical: xl,
  );

  static const EdgeInsets edgeInsetsSymmetricSm = EdgeInsets.symmetric(
    horizontal: sm,
    vertical: xs,
  );
  static const EdgeInsets edgeInsetsSymmetricMd = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  static const EdgeInsets edgeInsetsSymmetricLg = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMdSm = SizedBox(width: mdSm, height: mdSm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);
  static const SizedBox gapXxl = SizedBox(width: xxl, height: xxl);
}

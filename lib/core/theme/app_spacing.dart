import 'package:flutter/widgets.dart';

/// Spacing system layout values for margins, padding, and gap sizes.
class AppSpacing {
  AppSpacing._();

  /// Extra small: 4px spacing. Used for micro alignments (e.g. icon to text).
  static const double xs = 4.0;

  /// Small: 8px spacing. Used for tight groups of related controls.
  static const double sm = 8.0;

  /// Medium-small: 12px spacing. Used for standard child elements inside cards.
  static const double mdSm = 12.0;

  /// Medium: 16px spacing. Standard padding, margins, and gaps.
  static const double md = 16.0;

  /// Large: 24px spacing. Separating sections, title spacing, page margins.
  static const double lg = 24.0;

  /// Extra large: 32px spacing. Deep spacing between layout groups.
  static const double xl = 32.0;

  /// Double extra large: 48px spacing. Massive gaps.
  static const double xxl = 48.0;

  // --- WIDGET HELPER EDGEINSETS ---
  static const EdgeInsets edgeInsetsXs = EdgeInsets.all(xs);
  static const EdgeInsets edgeInsetsSm = EdgeInsets.all(sm);
  static const EdgeInsets edgeInsetsMdSm = EdgeInsets.all(mdSm);
  static const EdgeInsets edgeInsetsMd = EdgeInsets.all(md);
  static const EdgeInsets edgeInsetsLg = EdgeInsets.all(lg);
  static const EdgeInsets edgeInsetsXl = EdgeInsets.all(xl);

  // Horizontal Padding
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

  // Vertical Padding
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

  // Symmetric Padding
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

  // --- HEIGHT & WIDTH BOXES (for gap spacing) ---
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMdSm = SizedBox(width: mdSm, height: mdSm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);
  static const SizedBox gapXxl = SizedBox(width: xxl, height: xxl);
}

import 'package:flutter/widgets.dart';

/// Border radius definitions for UI components (buttons, cards, sheets, inputs).
class AppRadius {
  AppRadius._();

  /// Extra small: 4px radius. Used for tooltips or mini badges.
  static const double xs = 4.0;

  /// Small: 8px radius. Used for input fields, text fields, small buttons.
  static const double sm = 8.0;

  /// Medium: 12px radius. Standard card container, large buttons.
  static const double md = 12.0;

  /// Large: 16px radius. Used for bottom sheets, large dialogs, modal card views.
  static const double lg = 16.0;

  /// Extra large: 24px radius. Used for deep bottom sheets.
  static const double xl = 24.0;

  /// Full round: 99.0 radius. For circular buttons, profile avatars, chips.
  static const double circular = 99.0;

  // --- Radius Objects ---
  static const Radius radiusXs = Radius.circular(xs);
  static const Radius radiusSm = Radius.circular(sm);
  static const Radius radiusMd = Radius.circular(md);
  static const Radius radiusLg = Radius.circular(lg);
  static const Radius radiusXl = Radius.circular(xl);
  static const Radius radiusCircular = Radius.circular(circular);

  // --- BorderRadius Objects ---
  static const BorderRadius borderXs = BorderRadius.all(radiusXs);
  static const BorderRadius borderSm = BorderRadius.all(radiusSm);
  static const BorderRadius borderMd = BorderRadius.all(radiusMd);
  static const BorderRadius borderLg = BorderRadius.all(radiusLg);
  static const BorderRadius borderXl = BorderRadius.all(radiusXl);
  static const BorderRadius borderCircular = BorderRadius.all(radiusCircular);

  // Top-rounded corners (specifically for Bottom Sheets)
  static const BorderRadius borderTopLg = BorderRadius.only(
    topLeft: radiusLg,
    topRight: radiusLg,
  );
  static const BorderRadius borderTopXl = BorderRadius.only(
    topLeft: radiusXl,
    topRight: radiusXl,
  );
}

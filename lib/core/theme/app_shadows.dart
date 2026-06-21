import 'package:flutter/widgets.dart';

/// Shadow configurations following iOS visual styles.
///
/// Shadows in iOS are extremely soft, subtle, and use large blur radii
/// with very low opacities to avoid heavy, dated card-based interfaces.
class AppShadows {
  AppShadows._();

  /// Very light shadow for navigation bars or dividers.
  static const BoxShadow navBar = BoxShadow(
    color: Color(0x0A000000), // ~4% Black
    offset: Offset(0, 0.5),
    blurRadius: 0,
    spreadRadius: 0,
  );

  /// Subtle elevation for standard list cards.
  static const BoxShadow card = BoxShadow(
    color: Color(0x0F000000), // ~6% Black
    offset: Offset(0, 4),
    blurRadius: 12.0,
    spreadRadius: -2.0,
  );

  /// Slightly stronger elevation for floaters and pop-up widgets.
  static const BoxShadow elevated = BoxShadow(
    color: Color(0x14000000), // ~8% Black
    offset: Offset(0, 6),
    blurRadius: 18.0,
    spreadRadius: -1.0,
  );

  /// Pronounced shadow for dialog alerts or bottom sheets.
  static const BoxShadow modal = BoxShadow(
    color: Color(0x24000000), // ~14% Black
    offset: Offset(0, 10),
    blurRadius: 30.0,
    spreadRadius: -2.0,
  );

  // List packaging for standard BoxDecoration usage
  static const List<BoxShadow> listNavBar = [navBar];
  static const List<BoxShadow> listCard = [card];
  static const List<BoxShadow> listElevated = [elevated];
  static const List<BoxShadow> listModal = [modal];
}

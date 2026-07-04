import 'package:flutter/widgets.dart';

class AppShadows {
  AppShadows._();

  static const BoxShadow navBar = BoxShadow(
    color: Color(0x0A000000),
    offset: Offset(0, 0.5),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow card = BoxShadow(
    color: Color(0x0F000000),
    offset: Offset(0, 4),
    blurRadius: 12.0,
    spreadRadius: -2.0,
  );

  static const BoxShadow elevated = BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 6),
    blurRadius: 18.0,
    spreadRadius: -1.0,
  );

  static const BoxShadow modal = BoxShadow(
    color: Color(0x24000000),
    offset: Offset(0, 10),
    blurRadius: 30.0,
    spreadRadius: -2.0,
  );

  static const List<BoxShadow> listNavBar = [navBar];
  static const List<BoxShadow> listCard = [card];
  static const List<BoxShadow> listElevated = [elevated];
  static const List<BoxShadow> listModal = [modal];
}

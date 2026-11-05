import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double sm = 6.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 14.0;
  static const double xxl = 16.0;
  static const double round = 999.0;

  static const borderRadiusSm = BorderRadius.all(Radius.circular(sm));
  static const borderRadiusMd = BorderRadius.all(Radius.circular(md));
  static const borderRadiusLg = BorderRadius.all(Radius.circular(lg));
  static const borderRadiusXl = BorderRadius.all(Radius.circular(xl));
  static const borderRadiusXxl = BorderRadius.all(Radius.circular(xxl));
  static const borderRadiusRound = BorderRadius.all(Radius.circular(round));
}


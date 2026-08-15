import 'package:flutter/material.dart';

abstract final class AppColors {
  static const ink = Color(0xFF171715);
  static const inkMuted = Color(0xFF62615C);
  static const canvas = Color(0xFFF6F3ED);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFEDE8DE);
  static const line = Color(0xFFE2DDD3);
  static const gold = Color(0xFFB98A32);
  static const goldSoft = Color(0xFFF0E2C5);
  static const red = Color(0xFFD92D35);
  static const redSoft = Color(0xFFFFE8E8);
  static const blue = Color(0xFF185ADB);
  static const blueSoft = Color(0xFFE7EEFF);
  static const green = Color(0xFF23845B);
  static const greenSoft = Color(0xFFE4F4EB);
  static const whiteMuted = Color(0xCFFFFFFF);
  static const whiteSubtle = Color(0x99FFFFFF);
}

abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const huge = 48.0;
}

abstract final class AppRadii {
  static const sm = 12.0;
  static const md = 18.0;
  static const lg = 24.0;
  static const pill = 999.0;
}

abstract final class AppSizes {
  static const touch = 44.0;
  static const logoHeight = 34.0;
  static const supplierLogoBox = 72.0;
  static const productArtWidth = 72.0;
  static const productArtHeight = 94.0;
  static const bottomBarHeight = 72.0;
  static const iconSmall = 18.0;
  static const iconMedium = 22.0;
  static const iconLarge = 30.0;
  static const cardAspectRatio = 0.86;
  static const divider = 1.0;
}

abstract final class AppDurations {
  static const quick = Duration(milliseconds: 180);
  static const normal = Duration(milliseconds: 280);
}

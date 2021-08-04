import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

/// 拡張したカラー定義
class AdminColors {
  /// theme
  static const MaterialColor themeBlack = MaterialColor(
    _themeBlackPrimaryValue,
    <int, Color>{
      50: Color(_themeBlackPrimaryValue),
      100: Color(_themeBlackPrimaryValue),
      200: Color(_themeBlackPrimaryValue),
      300: Color(_themeBlackPrimaryValue),
      400: Color(_themeBlackPrimaryValue),
      500: Color(_themeBlackPrimaryValue),
      600: Color(_themeBlackPrimaryValue),
      700: Color(_themeBlackPrimaryValue),
      800: Color(_themeBlackPrimaryValue),
      900: Color(_themeBlackPrimaryValue),
    },
  );
  static const int _themeBlackPrimaryValue = 0xFF222222;
  static const Color themeTextPrimary = Color(0xFFEEEEEE);

  /// body
  static const Color bodyBackground = Color(0xFFF0F0F0);

  /// sideBar
  static const Color sideBarBackground = BootstrapColors.grayLight;
  static const Color sideBarActiveBackground = BootstrapColors.gray;
  static const Color sideBarBorder = BootstrapColors.gray;
  static const Color sideBarText = bodyBackground;
  static const Color sideBarFooterBackground = BootstrapColors.gray;
  static const Color sideBarFooterText = BootstrapColors.grayLight;

  /// heading
  static const Color headingBorder = BootstrapColors.grayLight;
}

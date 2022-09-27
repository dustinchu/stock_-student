import 'package:flutter/material.dart';

class AppColors {
  const AppColors({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.appBarColor,
    required this.error,
    required this.red,
    required this.green,
  });

  factory AppColors.light() {
    return const AppColors(
        primary: Color(0xff04368e),
        primaryVariant: Color(0xff03235c),
        secondary: Color(0xffa00505),
        secondaryVariant: Color(0xff6f0303),
        appBarColor: Color(0xff6f0303),
        error: Color(0xffb00020),
        red: Color.fromARGB(255, 229, 57, 53),
        green: Color.fromARGB(255, 67, 160, 71));
  }

  factory AppColors.dark() {
    return const AppColors(
        primary: Color(0xff5b7cb5),
        primaryVariant: Color(0xff5a6f94),
        secondary: Color(0xffc15c5c),
        secondaryVariant: Color(0xffa15a5a),
        appBarColor: Color(0xffa15a5a),
        error: Color(0xffcf6679),
        red: Color.fromARGB(255, 229, 57, 53),
        green: Color.fromARGB(255, 67, 160, 71));
  }

  /// Material Colors https://material.io/design/color/the-color-system.html#color-theme-creation
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color secondaryVariant;
  final Color appBarColor;
  final Color error;
  final Color red;
  final Color green;
}

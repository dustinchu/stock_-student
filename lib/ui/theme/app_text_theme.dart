import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'font_size.dart';

class AppTextTheme {
  const AppTextTheme._({
    required this.h10,
    required this.h20,
    required this.h30,
    required this.h40,
    required this.h50,
    required this.h60,
    required this.h70,
    required this.h80,
    required this.h90,
    required this.h100,
  });

  factory AppTextTheme() {
    final _normalRegular = GoogleFonts.notoSans(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
      ),
    );
    return AppTextTheme._(
      h10: TextStyle(fontSize: FontSize.pt16.sp).merge(_normalRegular),
      h20: TextStyle(fontSize: FontSize.pt16.sp).merge(_normalRegular),
      h30: TextStyle(fontSize: FontSize.pt20.sp).merge(_normalRegular),
      h40: TextStyle(fontSize: FontSize.pt16.sp).merge(_normalRegular),
      h50: TextStyle(fontSize: FontSize.pt20.sp).merge(_normalRegular),
      h60: TextStyle(fontSize: FontSize.pt24.sp).merge(_normalRegular),
      h70: TextStyle(fontSize: FontSize.pt32.sp).merge(_normalRegular),
      h80: TextStyle(fontSize: FontSize.pt40.sp).merge(_normalRegular),
      h90: TextStyle(fontSize: FontSize.pt48.sp).merge(_normalRegular),
      h100: TextStyle(fontSize: FontSize.pt60.sp).merge(_normalRegular),
    );
  }

  /// pt10
  final TextStyle h10;

  /// pt12
  final TextStyle h20;

  /// pt14
  final TextStyle h30;

  /// pt16
  final TextStyle h40;

  /// pt20
  final TextStyle h50;

  /// pt24
  final TextStyle h60;

  /// pt32
  final TextStyle h70;

  /// pt40
  final TextStyle h80;

  /// pt48
  final TextStyle h90;

  /// pt60
  final TextStyle h100;
}

extension TextStyleExt on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.w700);

  TextStyle comfort() => copyWith(height: 1.8);

  TextStyle dense() => copyWith(height: 1.2);
}

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

final appThemeModeProvider =
    StateNotifierProvider<StateController<ThemeMode>, ThemeMode>(
  (ref) => StateController(ThemeMode.dark),
);

final appThemeProvider = Provider<AppTheme>(
  (ref) {
    final mode = ref.watch(appThemeModeProvider);
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.dark();
      case ThemeMode.light:
      default:
        return AppTheme.light();
    }
  },
);

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.textTheme,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = FlexThemeData.light(
      scheme: FlexScheme.bahamaBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 18,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      appBarElevation: 0,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      lightIsWhite: false,
      useSubThemes: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // To use playground font, add GoogleFonts package and uncomment:
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedText: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = FlexThemeData.dark(
      scheme: FlexScheme.bahamaBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 18,
      appBarStyle: FlexAppBarStyle.background,
      appBarOpacity: 0.95,
      appBarElevation: 0,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      darkIsTrueBlack: false,
      useSubThemes: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // To use playground font, add GoogleFonts package and uncomment:
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedText: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppTextTheme textTheme;
  final AppColors appColors;
}

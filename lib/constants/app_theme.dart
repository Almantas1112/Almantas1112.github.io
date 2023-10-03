import 'package:flutter/material.dart';
import 'package:gov_tech/constants/font_family.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData themeData = ThemeData(
    fontFamily: FontFamily.mitr,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.scaffoldColor),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    useMaterial3: true,
  );

  static final ThemeData themeDataDark = themeData.copyWith(
    brightness: Brightness.dark,
  );
}

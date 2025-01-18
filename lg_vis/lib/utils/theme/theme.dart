import 'package:flutter/material.dart';
import 'package:lg_vis/utils/constants/colors.dart';
import 'package:lg_vis/utils/theme/appbar_theme.dart';
import 'package:lg_vis/utils/theme/button_theme.dart';
import 'package:lg_vis/utils/theme/text_theme.dart';

class LgAppTheme{
  LgAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    textTheme: LgTextTheme.lightTextTheme,
    elevatedButtonTheme: LgButtonTheme.lightButtonTheme,
    appBarTheme: LgAppbarTheme.lightAppBarTheme,
    splashColor: LgColors.splashLight,
    colorScheme: ColorScheme.light(
      surface: LgColors.light,
      surfaceContainer: LgColors.ContentLight,
    ),
  );
  static ThemeData DarkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    textTheme: LgTextTheme.darkTextTheme,
    elevatedButtonTheme: LgButtonTheme.darkElevatedButtonTheme,
    appBarTheme: LgAppbarTheme.darkAppBarTheme,
    splashColor: LgColors.splashDark,
    colorScheme: ColorScheme.dark(
      surface: LgColors.dark,
      surfaceContainer: LgColors.ContentDark
    ),

  );


}
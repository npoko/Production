// ignore_for_file: prefer_const_constructors

import 'package:engineer/themes/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Custom text theme
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
    ),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'sarabun',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: Color(0x1d1d1d),
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: Colors.white,
    drawerTheme: DrawerThemeData(
      backgroundColor: primary,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'Sarabun',
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      backgroundColor: Color(0x1d1d1d),
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

  // dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Sarabun',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: Color(0x1d1d1d),
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: primaryText,
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: primaryText,
      elevation: 0,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'Sarabun',
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      backgroundColor: Color(0x1d1d1d),
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );
}

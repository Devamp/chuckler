import 'package:flutter/material.dart';
/**
 * TODO add appropriate themes
 */

ColorScheme lightThemeColors(context) {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white54,
    onSecondary: Colors.black12,
    tertiary: Colors.amberAccent,
    onTertiary: Colors.black,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    surface: Colors.white,
    onSurface: Colors.black,
  );
}

ColorScheme darkThemeColors(context) {
  return const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white24,
      onSecondary: Colors.white70,
      tertiary: Colors.amberAccent,
      onTertiary: Colors.black,
      error: Color(0xFFF32424),
      onError: Color(0xFFF32424),
      surface: Colors.black,
      onSurface: Colors.white);
}

ThemeData lightThemeData(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return ThemeData(
    scaffoldBackgroundColor: lightThemeColors(context).onPrimary,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 20,
          letterSpacing: 0),
      headlineMedium: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 30,
          letterSpacing: 0),
      headlineSmall: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyLarge: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyMedium: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 50,
          letterSpacing: 0),
      bodySmall: TextStyle(
          color:  lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 60,
          letterSpacing: 0),
    ),
    colorScheme: lightThemeColors(context),
  );
}

ThemeData darkThemeData(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return ThemeData(
    scaffoldBackgroundColor: darkThemeColors(context).surface,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 20,
          letterSpacing: 0),
      headlineMedium: TextStyle(
          color:  darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 30,
          letterSpacing: 0),
      headlineSmall: TextStyle(
          color:  darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyLarge: TextStyle(
          color:  darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyMedium: TextStyle(
          color:  darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 50,
          letterSpacing: 0),
      bodySmall: TextStyle(
          color:  darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 60,
          letterSpacing: 0),
    ),
    colorScheme: darkThemeColors(context),
  );
}

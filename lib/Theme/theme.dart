import 'package:flutter/material.dart';

/// TODO add appropriate themes

// primary background gradient for all screens
LinearGradient primaryBackgroundGradient(context) {
  return const LinearGradient(colors: [
    Color.fromRGBO(9, 32, 63, 1),
    Color.fromRGBO(83, 120, 149, 1),
    Color.fromRGBO(9, 32, 63, 1),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}

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
    textTheme: TextTheme(
      displayMedium: const TextStyle(
          color: Color(0xFFffd230),
          fontFamily: 'Livvic',
          fontSize: 40,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 20,
          letterSpacing: 0),
      headlineMedium: TextStyle(
          color: lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 30,
          letterSpacing: 0),
      headlineSmall: TextStyle(
          color: lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyLarge: TextStyle(
          color: lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyMedium: TextStyle(
          color: lightThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 50,
          letterSpacing: 0),
      bodySmall: TextStyle(
          color: lightThemeColors(context).onPrimary,
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
    textTheme: TextTheme(
      displayMedium: const TextStyle(
          color: Color(0xFFffd230),
          fontFamily: 'Livvic',
          fontSize: 40,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 20,
          letterSpacing: 0),
      headlineMedium: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 30,
          letterSpacing: 0),
      headlineSmall: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyLarge: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 40,
          letterSpacing: 0),
      bodyMedium: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 50,
          letterSpacing: 0),
      bodySmall: TextStyle(
          color: darkThemeColors(context).onPrimary,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: screenHeight / 60,
          letterSpacing: 0),
    ),
    colorScheme: darkThemeColors(context),
  );
}

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF181D2D),
        secondary: Color(0xFF324A59),
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 22.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFF181D2D),
        ),
        headlineMedium: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFF181D2D),
        ),
        headlineSmall: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFF181D2D),
        ),
        bodyLarge: TextStyle(
          fontSize: 22.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFFAAAAAA),
        ),
        bodyMedium: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFFAAAAAA),
        ),
        bodySmall: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          color: Color(0xFFAAAAAA),
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Colors.yellowAccent,
        secondary: Colors.orange,
        surface: Colors.black,
      ),
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 22.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
          headlineMedium: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
          headlineSmall: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
          bodyLarge: TextStyle(
            fontSize: 22.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          )),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}

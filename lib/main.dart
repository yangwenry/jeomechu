import 'package:flutter/material.dart';
import 'package:jeomechu/screen/main_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: const ColorScheme(
        primary: Color(0xfffe6b00),
        onPrimary: Color(0xffffffff),
        secondary: Color(0xfffe6b00),
        onSecondary: Color(0xfffe6b00),
        error: Colors.redAccent,
        onError: Colors.white,
        background: Color(0xFFE6EBEB),
        onBackground: Colors.white,
        surface: Color(0xFFFAFBFB),
        onSurface: Color(0xFF241E30),
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 35,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
        ),
      ),
    ),
    home: const MainScreen(),
  ));
}

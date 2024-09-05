import 'package:flutter/material.dart';
import 'package:jeomechu/screen/home_screen.dart';
import 'package:jeomechu/screen/login_screen.dart';
import 'package:jeomechu/screen/title_screen.dart';
import 'package:jeomechu/screen/today_menu_screen.dart';

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
      textTheme: TextTheme(
        displayMedium: const TextStyle(
          fontSize: 35,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 30,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              blurRadius: 15.0,
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        headlineLarge: const TextStyle(
          fontSize: 40,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          fontSize: 30,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        titleMedium: const TextStyle(
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        bodyMedium: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        bodySmall: const TextStyle(
          fontSize: 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const TitleScreen(),
    routes: {
      '/title': (context) => const TitleScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
      '/today_menu': (context) => const TodayMenuScreen(),
    },
    initialRoute: '/title',
  ));
}

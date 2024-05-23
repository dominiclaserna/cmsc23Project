import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF05668d), // AppBar color
  scaffoldBackgroundColor: const Color(0xFFf0f3bd), // Background color
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF05668d),
  ),
  cardColor: const Color(0xFF028090), // Card color
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    buttonColor: const Color(0xFF00a896), // Primary button color
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF00a896), // Elevated button color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF02c39a), // Text button color
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF00a896), // FAB color
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF343A40)),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white), // Body text color

  ),
);

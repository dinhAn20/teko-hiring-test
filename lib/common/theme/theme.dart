import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = Colors.grey]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, surfaceTintColor: Colors.white),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(Colors.blue),
      errorBorder: _border(Colors.red),
    ),
  );
}

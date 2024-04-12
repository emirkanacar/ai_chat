import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFFfdfffe),
        secondary: Color(0xffcfdcf6)
    ),
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodySmall: const TextStyle(color: Colors.black),
      bodyMedium: const TextStyle(color: Colors.black),
      bodyLarge: const TextStyle(color: Colors.black),
      labelSmall: const TextStyle(color: Colors.black87),
      labelMedium: const TextStyle(color: Colors.black87),
      labelLarge: const TextStyle(color: Colors.black87),
      displaySmall: const TextStyle(color: Colors.black),
      displayMedium: const TextStyle(color: Colors.black),
      displayLarge: const TextStyle(color: Colors.black),
    ),
    dialogBackgroundColor: Colors.white,
    dividerColor: Colors.grey.withOpacity(0.3),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xff1f1f1f),
      selectionColor: Color(0xff1f1f1f).withOpacity(0.1)
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff1f1f1f),
      secondary: Color(0xff232323)
    ),
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodySmall: const TextStyle(color: Colors.white),
      bodyMedium: const TextStyle(color: Colors.white),
      bodyLarge: const TextStyle(color: Colors.white),
      labelSmall: const TextStyle(color: Colors.grey),
      labelMedium: const TextStyle(color: Colors.grey),
      labelLarge: const TextStyle(color: Colors.grey),
      displaySmall: const TextStyle(color: Colors.white),
      displayMedium: const TextStyle(color: Colors.white),
      displayLarge: const TextStyle(color: Colors.white),
    ),
    dialogBackgroundColor: const Color(0xFF1B1A1A),
    dividerColor: const Color(0xFF302F2F),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFFfdfffe),
      selectionColor: Color(0xFFfdfffe).withOpacity(0.1)
    ),
  );
}
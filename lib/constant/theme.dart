import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
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
  );

  static final darkTheme = ThemeData(
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
  );

  static final lightBackground = [
    const Color(0xFFfdfffe),
    const Color(0xffcfdcf6),
  ];

  static final darkBackground = [
    const Color(0xff1f1f1f),
    const Color(0xff232323),
  ];
}
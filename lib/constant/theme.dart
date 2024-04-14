import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xFFfdfffe),
      secondary: Color(0xffcfdcf6)
    ),
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodySmall: GoogleFonts.raleway(
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.raleway(
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.raleway(
        color: Colors.black,
      ),
      labelSmall: GoogleFonts.raleway(
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.raleway(
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.raleway(
        color: Colors.black87,
      ),
      displaySmall: GoogleFonts.raleway(
        color: Colors.black,
      ),
      displayLarge: GoogleFonts.raleway(
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.raleway(
        color: const Color(0xFF1f1f1f),
      ),
    ),
    dialogBackgroundColor: Colors.white,
    dividerColor: const Color(0xFFC8C5C5),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xff1f1f1f),
      selectionColor: const Color(0xff1f1f1f).withOpacity(0.1)
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      hintStyle: GoogleFonts.raleway(
        color: const Color(0xFF1f1f1f)
      ),
      prefixIconColor: const Color(0xFF1f1f1f),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xff1f1f1f),
      secondary: Color(0xff232323)
    ),
    useMaterial3: true,
    textTheme: const TextTheme().copyWith(
      bodySmall: GoogleFonts.raleway(
        color: Colors.white
      ),
      bodyMedium: GoogleFonts.raleway(
        color: Colors.white
      ),
      bodyLarge: GoogleFonts.raleway(
        color: Colors.white
      ),
      labelSmall: GoogleFonts.raleway(
        color: Colors.grey
      ),
      labelMedium: GoogleFonts.raleway(
        color: Colors.grey
      ),
      labelLarge: GoogleFonts.raleway(
        color: Colors.grey
      ),
      displaySmall: GoogleFonts.raleway(
        color: Colors.white
      ),
      displayLarge: GoogleFonts.raleway(
        color: Colors.white
      ),
      displayMedium: GoogleFonts.raleway(
        color: Colors.white,
      ),
    ),
    dialogBackgroundColor: const Color(0xFF1B1A1A),
    dividerColor: const Color(0xFF4f4d4d),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xFFfdfffe),
      selectionColor: const Color(0xFFfdfffe).withOpacity(0.1)
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xff1f1f1f),
      hintStyle: GoogleFonts.raleway(
        color: Colors.white70
      ),
      prefixIconColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
      )
    ),
  );
}
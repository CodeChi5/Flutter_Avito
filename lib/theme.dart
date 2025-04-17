import 'package:flutter/material.dart';

class AppTheme {
  // Define the custom colors for light theme
  static const Color primaryPink = Color(0xFFF7CFD8);
  static const Color lightGreen = Color(0xFFF4F8D3);
  static const Color teal = Color(0xFFA6D6D6);
  static const Color purple = Color(0xFF8E7DBE);

  // Define the custom colors for dark theme
  static const Color darkNavy = Color(0xFF27374D);
  static const Color darkBlue = Color(0xFF526D82);
  static const Color lightGray = Color(0xFF9DB2BF);
  static const Color offWhite = Color(0xFFDDE6ED);

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: purple,
      secondary: teal,
      tertiary: primaryPink,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      onSurface: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: purple,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: purple,
        side: const BorderSide(color: purple),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: purple),
      ),
      prefixIconColor: purple,
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: lightGray,
      secondary: darkBlue,
      tertiary: offWhite,
      surface: darkBlue,
      onPrimary: darkNavy,
      onSecondary: offWhite,
      onTertiary: darkNavy,
      onSurface: offWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkNavy,
      foregroundColor: offWhite,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightGray,
        foregroundColor: darkNavy,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: offWhite,
        side: const BorderSide(color: lightGray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    cardTheme: CardTheme(
      color: darkBlue,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightGray),
      ),
      prefixIconColor: lightGray,
    ),
  );
}

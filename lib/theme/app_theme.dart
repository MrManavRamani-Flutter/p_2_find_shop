import 'package:flutter/material.dart';

import 'font_size.dart'; // Assuming you have a file defining FontSize constants.

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(
      brightness: Brightness.light, // Set brightness in ColorScheme only
      secondary: Colors.teal,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: FontSize.headline1,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: FontSize.headline1,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: FontSize.headline2,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: FontSize.body,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: FontSize.small,
        color: Colors.black54,
      ),
      labelSmall: TextStyle(
        fontSize: FontSize.caption,
        color: Colors.black45,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[50],
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontSize: FontSize.body,
      ),
      hintStyle: const TextStyle(
        color: Colors.black45,
        fontSize: FontSize.small,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(
          fontSize: FontSize.button, // Corrected button text style
          color: Colors.white,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.teal,
        side: const BorderSide(color: Colors.teal, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(
          fontSize: FontSize.button, // Corrected button text style
          color: Colors.teal,
        ),
      ),
    ),
  );

// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(
      brightness: Brightness.dark, // Set brightness in ColorScheme only
      secondary: Colors.orange[300], // Changed to a warmer color
      surface: Colors.grey[850], // Slightly lighter for a better contrast
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    // Darker background
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueGrey,
      // Darker, more neutral tone
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: FontSize.headline1,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: FontSize.headline1,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: FontSize.headline2,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontSize: FontSize.body,
        color: Colors.white70, // Subtle contrast
      ),
      bodyMedium: TextStyle(
        fontSize: FontSize.small,
        color: Colors.white54, // Lighter text for less important content
      ),
      labelSmall: TextStyle(
        fontSize: FontSize.caption,
        color: Colors.white38, // Lighter label text for minimal contrast
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800], // Subtle grey for cards
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[700],
      // Slightly lighter for input backgrounds
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(
        color: Colors.white70,
        fontSize: FontSize.body,
      ),
      hintStyle: const TextStyle(
        color: Colors.white54,
        fontSize: FontSize.small,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[300], // Changed to warm color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(
          fontSize: FontSize.button, // Corrected button text style
          color: Colors.black87, // Darker text for better contrast
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.orange[300], // Changed to match primary theme
        side: BorderSide(color: Colors.orange[300]!, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: TextStyle(
          fontSize: FontSize.button, // Corrected button text style
          color: Colors.orange[300],
        ),
      ),
    ),
  );
}

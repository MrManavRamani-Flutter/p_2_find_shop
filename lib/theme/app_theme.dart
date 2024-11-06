import 'package:flutter/material.dart';
import 'package:p_2_find_shop/theme/font_size.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: FontSize.body),
      bodyMedium: TextStyle(fontSize: FontSize.body),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: FontSize.body),
      bodyMedium: TextStyle(fontSize: FontSize.body),
    ),
  );
}

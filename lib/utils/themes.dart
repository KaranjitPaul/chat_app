import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primaryContainer: Color(0xff2563EB),
      onPrimaryContainer: Colors.white,
    ),
  );
  static ThemeData darkTheme(BuildContext context) => ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade700,
      primaryContainer: Color(0xff2563EB),
      onPrimaryContainer: Colors.white,
    ),
  );
}

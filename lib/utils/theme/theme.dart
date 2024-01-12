import 'package:flutter/material.dart';
import 'package:greenmate/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:greenmate/utils/theme/custom_themes/text_theme.dart';

class greenMateTheme {
  greenMateTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF128750)),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF128750),
    scaffoldBackgroundColor: Colors.white,
    textTheme: greenmateTextTheme.lightTextTheme,
    elevatedButtonTheme: greenMateElevatedButtonTheme.lightElevatedButtonTheme
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF128750)),
    useMaterial3: true,
    //brightness: Brightness.dark,
    primaryColor: Color(0xFF128750),
    scaffoldBackgroundColor: Colors.black87,
    textTheme: greenmateTextTheme.darkTextTheme, elevatedButtonTheme: greenMateElevatedButtonTheme.darkElevatedButtonTheme

  );
}
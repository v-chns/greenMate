import 'package:flutter/material.dart';

class greenMateElevatedButtonTheme{
  greenMateElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0.5,
      foregroundColor: Colors.white,
      backgroundColor: Colors.green[800],
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.green),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  elevation: 0.5,
  foregroundColor: Colors.white,
  backgroundColor: Colors.green[800],
  disabledForegroundColor: Colors.grey,
  disabledBackgroundColor: Colors.grey,
  side: const BorderSide(color: Colors.green),
  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
  textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

  ),
  );

}
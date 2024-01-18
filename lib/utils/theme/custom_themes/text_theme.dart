import 'package:flutter/material.dart';

class greenmateTextTheme {
  greenmateTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 19.0, fontWeight: FontWeight.w600, color: Colors.black),

    titleLarge: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.5)),

    bodyLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black, fontStyle: FontStyle.italic),
    labelMedium: const TextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5), fontStyle: FontStyle.italic),
    labelSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5), fontStyle: FontStyle.italic),
  );


  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 19.0, fontWeight: FontWeight.w600, color: Colors.white),

    titleLarge: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.5)),

    bodyLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.white, fontStyle: FontStyle.italic),
    labelMedium: const TextStyle().copyWith(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic),
    labelSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic),
  );

}
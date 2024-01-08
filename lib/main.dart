import 'package:flutter/material.dart';
import 'package:greenmate/features/screens/Home.dart';
import 'package:greenmate/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenMate',
      themeMode: ThemeMode.system,
      theme: greenMateTheme.lightTheme,
      darkTheme: greenMateTheme.darkTheme,
      home: Home(),
    );
  }
}
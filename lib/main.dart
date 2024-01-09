import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:greenmate/features/screens/Home.dart';
import 'package:greenmate/features/screens/Tutorial.dart';
import 'package:greenmate/utils/theme/theme.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GreenMate',
      themeMode: ThemeMode.system,
      theme: greenMateTheme.lightTheme,
      darkTheme: greenMateTheme.darkTheme,
      home: const Home(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/tutorial', page: () => const Tutorial()),
      ],
    );
  }
}
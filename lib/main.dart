import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:greenmate/data/cache/CacheManager.dart';
import 'package:greenmate/data/cache/SharedPreferencesManager.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/data/services/PlantSqlListService.dart';
import 'package:greenmate/data/services/db/DatabaseService.dart';
import 'package:greenmate/features/models/ChatMessage.dart';
import 'package:greenmate/features/models/MyPlant.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/Dashboard.dart';
import 'package:greenmate/features/screens/EcoGuide.dart';
import 'package:greenmate/features/screens/Home.dart';
import 'package:greenmate/features/screens/PlantDetails.dart';
import 'package:greenmate/features/screens/Tutorial.dart';
import 'package:greenmate/utils/constants/dummyplant.dart';
import 'package:greenmate/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = DatabaseService.instance;
  await databaseService.initDatabase();
  // final database = openDatabase(join(await getDatabasesPath(), 'greenmate_localdb.db'), 
  
  // onCreate: (db, version) {
  //   // Run the CREATE TABLE statement on the database.
  //   return db.execute(
  //     'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  //   );
  // },);

  cameras = await availableCameras();

  // Cache Loading
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  GetPlantsList getPlantsList = GetPlantsList();
  chatHistory = await SharedPreferencesManager.getChatHistory();
  allPlants = await getPlantsList.getAllPlants();
  MyPlant.myPlants = await PlantSqlLiteService().getMyPlants();  

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

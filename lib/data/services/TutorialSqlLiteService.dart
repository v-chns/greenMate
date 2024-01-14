import 'dart:io';
import 'dart:math';

import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/data/services/db/DatabaseService.dart';
import 'package:greenmate/features/models/MyTutorial.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:sqflite/sqflite.dart';

class TutorialSqlLiteService {
  int generateRandomNumber() {
    final random = Random();
    return 1 + random.nextInt(10000 - 1 + 1);
  }

  Future<void> addTutorialToLocalDB(Plant plant) async {
    DatabaseService databaseService = DatabaseService.instance;
    Database db = await databaseService.database;

    plant.userTutorialId = generateRandomNumber();
    await db.insert('my_tutorials', plant.toDBTutorialObject(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Plant>> getMyTutorials() async {
    List<Plant> output = [];
    DatabaseService databaseService = DatabaseService.instance;
    Database db = await databaseService.database;
    GetPlantsList getPlantsList = GetPlantsList();

    final List<Map<String, dynamic>> res = await db.query('my_tutorials');

    for (var i in res) {
      final String classPlant = i['class'];
      // print(classPlant);
      Plant? genericData = await getPlantsList.getPlantByClass(classPlant);
      // print("babi");
      // print(genericData);
      if (genericData != null) {
        genericData.setUserTutorialData(i['userTutorialId']);
        output.add(genericData);
      }
    }

    MyTutorial.myTutorials = output;

    return output;
  }

  Future<int> deleteTutorial(int id) async {
    DatabaseService databaseService = DatabaseService.instance;
    Database db = await databaseService.database;

    // final List<Map<String, dynamic>> res =
    // await db.query('my_tutorials', where: 'userTutorialId = ?', whereArgs: [id]);


    // File file = File(res[0]['userImage']);

    // print(res[0]);

    return await db.delete('my_tutorials', where: 'userTutorialId = ?', whereArgs: [id]);
  }
}

import 'dart:io';
import 'dart:math';

import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/data/services/db/DatabaseService.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// late final database;
class PlantSqlLiteService {
  int generateRandomNumber() {
    final random = Random();
    return 1 + random.nextInt(10000 - 1 + 1);
  }

  Future<String> saveImage(XFile imageFile) async {
    try {
      final externalDirectory = await getExternalStorageDirectory();
      final imagePath = '${externalDirectory!.path}/my_images';
      await Directory(imagePath).create(recursive: true);

      final imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
      final savedImage = File('$imagePath/$imageName');
      await savedImage.writeAsBytes(await imageFile.readAsBytes());

      return '$imagePath/$imageName';
    } catch (e) {
      print('Error saving image: $e');
      throw e;
    }
  }

  Future<void> addPlantToLocalDB(Plant plant, XFile imageFile) async {
    DatabaseService databaseService = DatabaseService.instance;
    Database db = await databaseService.database;

    String imgDir = await saveImage(imageFile);
    plant.userPlantId = generateRandomNumber();
    plant.userImage = imgDir;
    await db.insert('my_plants', plant.toDBObject(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Plant>> getMyPlants() async {
    List<Plant> output = List.empty();
    DatabaseService databaseService = DatabaseService.instance;
    Database db = await databaseService.database;
    GetPlantsList getPlantsList = GetPlantsList();

    final List<Map<String, dynamic>> res = await db.query('my_plants');

    for (int i = 0; i < res.length; i++) {
      final String classPlant = res[i]['class'];
      Plant? genericData = await getPlantsList.getPlantByClass(classPlant);
      if (genericData != null) {
        genericData.setUserData(res[i]['userPlantId'], res[i]['userImage']);
        output.add(genericData);
      }
    }

    return output;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class PlantDetectionService {
  static const String _baseUrl = APIConstants.baseURL;
  static const String _token = APIConstants.authKey;

  static Future<String> detectPlant(String imagePath) async {
    try {
      final Uri uri = Uri.parse(_baseUrl + "images/classify/plant");

      List<int> imageBytes = await File(imagePath).readAsBytes();

      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile.fromBytes(
          'imgData',
          imageBytes,
          filename: 'testImage.jpg',
        ),
      );

      // request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = _token;

      final response = await request.send();    

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(await response.stream.bytesToString());
        
        if (jsonResponse['data'] != null) {
          Plant newPlant = Plant.fromJson(jsonResponse);
          String plantName = newPlant.name;
          String plantClass = newPlant.plantClass;

          return 'Detected plant: $plantClass - $plantName';
        } else {
          return 'Plant not found in the image.';
        }
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
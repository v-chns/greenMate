import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPlantsList {
  List<Plant> plantList = [];
  static const String _baseUrl = APIConstants.baseURL;
  static const String _token = APIConstants.authKey;

  // Get All Plants in Database
  Future<List<Plant>> getAllPlants() async {
    final urlString = _baseUrl + 'plants/get';
    final url = Uri.parse(urlString);
    final response = await http.get(
      url,
      headers: {'Authorization': _token},
    );

    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // print('error 1');
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print('error 2');
      final List<dynamic> data = responseData['data'];
      // print('error 3');
      print('Decoded Data: $data');
      plantList = data.map((plantData) => Plant.fromJson1(plantData)).toList();
      // print('error 4');
      return plantList;
    } else {
      throw Exception('Failed to load plants');
    }
  }

  // Get Specific Plant
  Future<Plant?> getPlantByClass(String className) async {
    final urlString = _baseUrl + 'plants/get';
    final url = Uri.parse('$urlString/$className');
    final response = await http.get(
      url,
      headers: {'Authorization': _token},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if(data != null){
        return Plant.fromJson(data);
      }
      return null;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load plant');
    }
  }
}
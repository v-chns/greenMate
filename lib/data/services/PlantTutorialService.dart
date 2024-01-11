import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class PlantTutorialService {
  static const String _baseUrl = APIConstants.baseURL;
  static const String _token = APIConstants.authKey;

  static Future<String> generatePlantTutorial(String imagePath) async {
    return "";
  }
}
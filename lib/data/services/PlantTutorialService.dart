import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class PlantTutorialService {
  static const String _baseUrl = APIConstants.baseURL;
  static const String _token = APIConstants.authKey;

  static Future<String> generatePlantTutorial(String plantName) async {

    try {
      final String url = _baseUrl + 'gpt/generate-tutorial/';

      Uri uri = Uri.parse('$url$plantName');

      final headers = {
        'Authorization': _token,
      };

      var response = await http.get(uri, headers: headers);

      print("response:");
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Error: ${response.statusCode}';
      }
    }
    catch (error) {
        // Handle other errors, e.g., return an error message
        return 'Error: $error';
    }


  }
}
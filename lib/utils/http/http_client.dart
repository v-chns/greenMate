import 'dart:convert';
import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class httpHelper {
  static const String _baseUrl = APIConstants.baseURL;

  static const headers = {
    'Authorization': APIConstants.authKey,
  };

  // GET
  static Future<Map<String, dynamic>> get(String endpoint) async {
    Uri uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.get(uri, headers: headers, );
    return _handleResponse(response);
  }

  // POST
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    Uri uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.post(uri, headers: {'Content-Type': 'application/json'}, body: json.encode(data), );
    return _handleResponse(response);
  }

  // PUT

  // DELETE

  // Handle
  static Map<String, dynamic> _handleResponse(http.Response response){
    if(response.statusCode == 200){
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
import 'dart:convert';

import 'package:greenmate/features/models/ChatMessage.dart';
import 'package:greenmate/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ChatBotService {
  static const String _baseUrl = APIConstants.baseURL;
  static const String _token = APIConstants.authKey;

  static Future<ChatMessage?> send(List<ChatMessage> _messages) async {
    Uri apiUrl = Uri.parse(_baseUrl + "gpt/chat");

    List<Map<String, dynamic>> jsonList =
        _messages.map((obj) => obj.toJson()).toList();
    // call chatbot api
    Map<String, dynamic> jsonData = {'chat': jsonList};

    print(jsonEncode(jsonData));

    try {
      final res = await http.post(apiUrl,
          headers: <String, String>{
            'Content-Type' : 'application/json',
            'Authorization': _token},
          body: jsonEncode(jsonData));

      // var req = http.Request('POST', apiUrl);
      // req.headers['Authorization'] = _token;
      // req.body = jsonEncode(jsonData);
      // print(req.headers);
      // final res = await req.send();

      print(res.statusCode);
      if (res.statusCode == 200) {
        print("babi");
        final Map<String, dynamic> jsonResponse = json.decode(res.body);

        if (jsonResponse['data'] != null) {
          ChatMessage newMessage = ChatMessage.fromJson(jsonResponse);
          return newMessage;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
    }
  }
}

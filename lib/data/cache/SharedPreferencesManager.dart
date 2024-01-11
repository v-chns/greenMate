import 'dart:convert';

import 'package:greenmate/features/models/ChatMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager{
  static Future<List<ChatMessage>> getChatHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('chat');
    if(jsonString!=null){
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<ChatMessage> history = jsonList.map((json) => ChatMessage.fromSharedPreferences(json)).toList();
      return history.isEmpty ? List.empty() : history;
    }else{
      return List.empty();
    }
  }

  static Future<void> saveObjectList(List<ChatMessage> objectList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of objects to a JSON string
    final jsonString = jsonEncode(objectList.map((obj) => obj.toJson()).toList());

    // Save the JSON string to SharedPreferences
    prefs.setString('chat', jsonString);

    print('Object list saved to SharedPreferences.');
  }
}
import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenmate/data/cache/CacheManager.dart';
import 'package:greenmate/data/cache/SharedPreferencesManager.dart';
import 'package:greenmate/data/services/ChatBotService.dart';
import 'package:greenmate/features/models/ChatMessage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:http/http.dart' as http;

late List<ChatMessage> chatHistory;

class EcoGuide extends StatefulWidget {
  final List<ChatMessage> history = chatHistory;

  EcoGuide({super.key});
  @override
  _EcoGuideState createState() => _EcoGuideState();
}

class _EcoGuideState extends State<EcoGuide> {
  ChatMessage init = ChatMessage(
      role: 'assistant',
      content:
          "Hi, I'm Eco, your Botanical Assistant! What can I help you with?");
  TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(widget.history);
    if (_messages.isEmpty) {
      _messages.add(init);
    }
  }

  void _sendMessage(String message) {
    setState(() {
      ChatMessage newMessage = ChatMessage(role: "user", content: message);
      _messages.add(newMessage);
      _messageController.clear();

      receiveMessage(_messages);
    });
  }

  void receiveMessage(List<ChatMessage> messages) async {
    ChatMessage temp = ChatMessage(role: 'assistant', content: ". . .");
    setState(() {
      _messages.add(temp);
    });
    ChatMessage? newMessage = await ChatBotService.send(messages);
    if (newMessage != null) {
      setState(() {
        _messages.last = newMessage;
      });
      await SharedPreferencesManager.saveObjectList(_messages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('EcoGuide', style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white
          ),),
          backgroundColor: Color(0xFF128750)
      ),
      body: Padding (
        padding: EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
        child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: BubbleSpecialThree(
                            text: _messages[index].content,
                            isSender:
                            _messages[index].role == 'user' ? true : false,
                            tail: true,
                            color: _messages[index].role == 'user'
                                ? Colors.green.shade800
                                : Colors.lightGreen.shade100,
                            textStyle: TextStyle(
                                color: _messages[index].role == 'user'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ask Eco for home gardening tips ...',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(width: 1, color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1, color: Color(0xFF128750)), // Adjust the focused border color
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        String message = _messageController.text.trim();
                        if (message.isNotEmpty) {
                          _sendMessage(message);
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              )
            ]),
      )
    );
  }
}

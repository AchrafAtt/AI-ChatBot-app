import 'package:chat_bot/chat/data/grok_api_service.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class ChatProvider with ChangeNotifier {
  final _apiService = GroqApiService(apiKey: "YOUR_API_KEY");

  //Messages loading
  final List<Message> _messages = [];
  bool _isLoading = false;

  //Getters
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  //Send message to the API
  Future<void> sendMessage(String content) async {
    //prevent empty messages
    if (content.trim().isEmpty) return;

    //user message
    final userMessage = Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
    //add user message to chat
    _messages.add(userMessage);

    //update UI
    notifyListeners();

    //start loading
    _isLoading = true;

    //update UI
    notifyListeners();
    //send message and receive response

    try {
      final response = await _apiService.sendMessage(content);
      //add response to chat
      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(responseMessage);
    } catch (e) {
      //add error message to chat
      final errorMessage = Message(
        content: "Error: $e",
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(errorMessage);
    }
    _isLoading = false;
    notifyListeners();
  }
}

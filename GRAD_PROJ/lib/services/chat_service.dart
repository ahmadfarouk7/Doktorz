// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/models/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<ChatModel> sendMessage({required String message}) async {
    http.Response response = await http
        .post(Uri.parse('https://gemini-chatbot-1.onrender.com/ask'),
            body: jsonEncode({
              "question": message,
            }),
            headers: {'Content-Type': 'application/json'});
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data['response']);
    return ChatModel(message: data['response'], chatIndex: 1);
  }
}

import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import '../models/message_model.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _chatService.getMessages(chatId);
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    await _chatService.sendMessage(chatId, message);
  }
}
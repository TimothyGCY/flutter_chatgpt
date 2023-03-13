import 'package:chatgpt/constants/sender.dart';
import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class MessagingProvider with ChangeNotifier {
  final List<Message> _messageList = [];

  List<Message> get chats => _messageList;

  void appendMessage(String model, String message) async {
    _messageList.add(Message(
      message: message,
      sender: Sender.user,
    ));
    notifyListeners();

    APIService.submitQuery(model, message).then((responseMsg) {
      _messageList.add(responseMsg);
      notifyListeners();
      debugPrint('notified');
    });
  }

  void clearChat() {
    _messageList.clear();
    notifyListeners();
  }
}

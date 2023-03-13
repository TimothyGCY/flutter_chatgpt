import 'package:chatgpt/constants/sender.dart';
import 'package:flutter/material.dart';

class Message {
  Message({
    Key? key,
    required this.message,
    required this.sender,
  });

  final String message;
  final Sender sender;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: (json['choices'][0]['text'] as String).trim(),
        sender: Sender.bot,
      );
}

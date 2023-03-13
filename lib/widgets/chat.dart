import 'package:chatgpt/constants.dart';
import 'package:chatgpt/constants/sender.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key, required this.message, required this.sender});

  final String message;
  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sender == Sender.user ? scaffoldBackgroundColor : cardColor,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child:
                Icon(sender == Sender.bot ? Icons.data_object : Icons.person),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          // Row(
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.thumb_up,
          //         color: Colors.white,
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.thumb_down,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

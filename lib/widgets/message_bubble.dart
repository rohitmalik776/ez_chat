import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.username, {Key? key})
      : super(key: key);
  final Message message;
  final String username;
  @override
  Widget build(BuildContext context) {
    final bool isCurrentUser = message.author == username;
    return Stack(
      alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Align(
          alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              message.author,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

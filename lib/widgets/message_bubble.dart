import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, {Key? key}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Text(message),
    );
  }
}

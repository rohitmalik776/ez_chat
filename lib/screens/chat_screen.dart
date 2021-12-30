import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as soc_io;

import '../providers/socket_provider.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String message = '';
    TextEditingController _textController = TextEditingController();
    var mediaQuery = MediaQuery.of(context);
    var socketProvider = Provider.of<SocketProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EZ Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...socketProvider.globalMessages.map((message) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: MessageBubble(message),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Send a message',
                      ),
                      onChanged: (currMessage) {
                        message = currMessage;
                      }),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (message.isNotEmpty) {
                    socketProvider.sendGlobalMessage(message);
                    message = '';
                    _textController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

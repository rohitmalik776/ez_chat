import 'package:flutter/material.dart';
import 'package:hello_world/models/message.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    String username = auth.username ?? 'unknown user';
    String messageText = '';
    TextEditingController _textController = TextEditingController();
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
                      child: SizedBox(
                        height: message.imageBytes == null ? 60 : 200,
                        child: MessageBubble(message, username),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Send a message',
                    ),
                    onChanged: (currMessage) {
                      messageText = currMessage;
                    }),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (messageText.isNotEmpty) {
                    socketProvider.sendGlobalMessage(
                      Message(
                        text: messageText,
                        author: username,
                        timestamp: DateTime.now(),
                      ),
                    );
                    messageText = '';
                    _textController.clear();
                  }
                },
              ),
              IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    var image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    var binaryImage = await image?.readAsBytes();
                    socketProvider.sendGlobalMessage(Message(
                      text: '',
                      author: username,
                      timestamp: DateTime.now(),
                      imageBytes: binaryImage,
                    ));
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

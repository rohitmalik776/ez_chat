import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as soc_io;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // void emitSomething() {
  //   print('emitting!');
  //   try {
  //     socket.emit('something', 'This is the emitted data!');
  //     print('emitted!');
  //   } catch (e) {
  //     print('couldn\'t emit, error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // connectToServer();
    return Scaffold(
      appBar: AppBar(
        title: const Text('EZ Chat'),
      ),
      body: Column(
        children: [
          // Text('Nice, connection status of socket is: ${socket.connected}')
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: emitSomething,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import './providers/socket_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocketProvider socket = Provider.of<SocketProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    String username = '';
    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            const Text(
                'Enter your name below to connect to the local chat room'),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Enter your name', labelText: 'Name'),
              onChanged: (value) {
                username = value;
              },
            ),
            ElevatedButton(
              child: const Text('Connect'),
              onPressed: () {
                socket.connectToServer(username);
              },
            ),
          ],
        ),
      ),
    );
  }
}

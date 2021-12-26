import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as soc_io;

class SocketProvider with ChangeNotifier {
  final socket = soc_io.io('ws://192.168.0.104:5000/', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  void connectToServer(String username) {
    socket.connect();
    socket.on('connect', (uid) {
      debugPrint('$uid Connected to server!');
      socket.emit('userConnected', username);
    });
    socket.on('message received', handleMessage);
  }

  void handleMessage(data) {
    print(data);
  }
}

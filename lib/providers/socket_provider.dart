import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as soc_io;

class SocketProvider with ChangeNotifier {
  final Map<String, List<String>> _messages = {'global': []};
  final socket = soc_io.io('ws://192.168.0.104:5000/', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  void connectToServer(String username) {
    socket.connect();
    socket.on('connect', (uid) {
      debugPrint('$uid Connected to server!');
      socket.emit('connect', username);
    });

    socket.on('global message', (data) {
      _addGlobalMessage(data.toString());
    });
  }

  void _addGlobalMessage(String message) {
    _messages['global']?.add(message);
    notifyListeners();
  }

  void sendGlobalMessage(String message) {
    socket.emit('global message', message);
    notifyListeners();
  }

  List<String> get globalMessages {
    return [...?_messages['global']];
  }
}

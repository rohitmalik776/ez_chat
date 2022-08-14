import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as soc_io;

import '../models/message.dart';
import '../constants.dart';

class SocketProvider with ChangeNotifier {
  final Map<String, List<Message>> _messages = {'global': []};
  soc_io.Socket? socket;
  void connectToServer(String username, String jwt) {
    socket = socket ??
        soc_io.io(socketUrl, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
          'extraHeaders': {
            'Authorization': {jwt}
          }
        });
    socket?.connect();
    socket?.on('connect', (uid) {
      print('connected!');
    });

    socket?.on('global message', (data) {
      _addGlobalMessage(data.toString());
    });
  }

  void _addGlobalMessage(String messageData) {
    _messages['global']?.add(Message.fromJson(messageData));
    notifyListeners();
  }

  void sendGlobalMessage(Message message) {
    var encodedMessage = jsonEncode(message.toJson());
    socket?.emit('global message', encodedMessage);
  }

  List<Message> get globalMessages {
    return [...?_messages['global']];
  }
}

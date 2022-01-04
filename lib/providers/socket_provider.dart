import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:socket_io_client/socket_io_client.dart' as soc_io;

import '../models/message.dart';

class SocketProvider with ChangeNotifier {
  final Map<String, List<Message>> _messages = {'global': []};
  final socket = soc_io.io('ws://192.168.0.104:5000/', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  void connectToServer(String username) {
    socket.connect();
    socket.on('connect', (uid) {
      print('connected!');
    });

    socket.on('global message', (data) {
      _addGlobalMessage(data.toString());
    });
  }

  void _addGlobalMessage(String messageData) {
    _messages['global']?.add(Message.fromJson(messageData));
    notifyListeners();
  }

  void sendGlobalMessage(Message message) {
    var encodedMessage = jsonEncode(message.toJson());
    print('send: $encodedMessage');
    socket.emit('global message', encodedMessage);
  }

  List<Message> get globalMessages {
    return [...?_messages['global']];
  }
}

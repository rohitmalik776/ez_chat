import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homepage.dart';
import './providers/socket_provider.dart';
import './chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SocketProvider>(create: (_) => SocketProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          ChatScreen.routeName: (ctx) => const ChatScreen(),
        },
      ),
    );
  }
}

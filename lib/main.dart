import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';
import './providers/socket_provider.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<SocketProvider>(create: (_) => SocketProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          ChatScreen.routeName: (ctx) => const ChatScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:hello_world/screens/chat_screen.dart';

import 'package:provider/provider.dart';
import '../providers/socket_provider.dart';

enum LoginState { toLogin, loggingIn, loginFailed }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  LoginState loginState = LoginState.toLogin;
  Widget build(BuildContext context) {
    SocketProvider socket = Provider.of<SocketProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    String username = '';
    String password = '';

    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            const Text('Enter your username and password!'),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Enter your name', labelText: 'Name'),
              onChanged: (value) {
                username = value;
              },
            ),
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Enter your password'),
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
              child: Column(
                children: [
                  (loginState == LoginState.toLogin)
                      ? const Icon(Icons.chevron_right)
                      : (loginState == LoginState.loggingIn)
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.close),
                  (loginState == LoginState.toLogin)
                      ? const Text('Log in')
                      : (loginState == LoginState.loggingIn)
                          ? const Text('Logging in...')
                          : const Text('Login failed!'),
                ],
              ),
              onPressed: () async {
                setState(() {
                  loginState = LoginState.loggingIn;
                });
                print(loginState);
                bool loginSuccess = await auth.signIn(username, password);
                // After authentication
                if (loginSuccess == false) {
                  setState(() {
                    loginState = LoginState.loginFailed;
                    print('login failed');
                  });
                  return;
                }
                socket.connectToServer(auth.username);
                Navigator.of(context).pushReplacementNamed(
                  ChatScreen.routeName,
                  arguments: {'username': auth.username},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

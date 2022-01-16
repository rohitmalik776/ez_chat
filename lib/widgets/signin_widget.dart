import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:hello_world/providers/socket_provider.dart';
import 'package:hello_world/screens/chat_screen.dart';
import 'package:hello_world/utils/process_state_enums.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  ProcessState processState = ProcessState.idle;
  bool _isObfuscated = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    SocketProvider socket = Provider.of<SocketProvider>(context, listen: false);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      children: [
        const Text('Enter your username and password!'),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
              hintText: 'Enter your username', labelText: 'username'),
          onChanged: (value) {
            username = value;
          },
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            labelText: 'password',
            suffix: IconButton(
              icon:
                  Icon(_isObfuscated ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isObfuscated = !_isObfuscated;
                });
              },
            ),
          ),
          obscureText: _isObfuscated,
          onChanged: (value) {
            password = value;
          },
        ),
        ElevatedButton(
          child: Column(
            children: [
              (processState == ProcessState.idle)
                  ? const Icon(Icons.chevron_right)
                  : (processState == ProcessState.loading)
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.close),
              (processState == ProcessState.idle)
                  ? const Text('Log in')
                  : (processState == ProcessState.loading)
                      ? const Text('Logging in...')
                      : const Text('Login failed!'),
            ],
          ),
          onPressed: () async {
            setState(() {
              processState = ProcessState.loading;
            });
            bool loginSuccess = await auth.signIn(username, password);
            // After authentication
            if (loginSuccess == false) {
              setState(() {
                processState = ProcessState.fail;
                _usernameController.value = TextEditingValue(text: username);
                _passwordController.value = TextEditingValue(text: password);
              });
              return;
            }
            socket.connectToServer(auth.username!);
            Navigator.of(context).pushReplacementNamed(
              ChatScreen.routeName,
            );
          },
        ),
      ],
    );
  }
}

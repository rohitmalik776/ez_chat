import 'package:flutter/material.dart';
import 'package:hello_world/providers/auth_provider.dart';
import 'package:hello_world/providers/socket_provider.dart';
import 'package:hello_world/screens/chat_screen.dart';
import 'package:hello_world/utils/process_state_enums.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  ProcessState loginState = ProcessState.idle;
  bool _isObfuscated = true;

  @override
  Widget build(BuildContext context) {
    SocketProvider socket = Provider.of<SocketProvider>(context, listen: false);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    String username = '';
    String password = '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Enter your username and password to Sign Up'),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your username',
            labelText: 'username',
          ),
          onChanged: (value) {
            username = value;
          },
        ),
        TextField(
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
              (loginState == ProcessState.idle)
                  ? const Icon(Icons.chevron_right)
                  : (loginState == ProcessState.loading)
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.close),
              (loginState == ProcessState.idle)
                  ? const Text('Sign up')
                  : (loginState == ProcessState.loading)
                      ? const Text('Signing you up...')
                      : const Text('Sign up failed!'),
            ],
          ),
          onPressed: () async {
            setState(() {
              loginState = ProcessState.loading;
            });
            bool signupSuccess = await auth.signUp(username, password);
            if (signupSuccess == false) {
              setState(() {
                loginState = ProcessState.fail;
              });
              return;
            }
            bool loginSuccess = await auth.signIn(username, password);
            // After authentication
            if (loginSuccess == false) {
              setState(() {
                loginState = ProcessState.fail;
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

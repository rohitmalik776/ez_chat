import 'package:flutter/material.dart';
import '/widgets/signup_widget.dart';

import '../widgets/signin_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            _isLogin ? const LoginWidget() : const SignupWidget(),
            ElevatedButton(
              child: Text(
                _isLogin ? 'Want to sign up?' : 'Login instead',
              ),
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

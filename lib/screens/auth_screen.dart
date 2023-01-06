import 'package:firebase_chat/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthForm(),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text("Signup"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

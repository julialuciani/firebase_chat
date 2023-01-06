import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Name"),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
          )
        ],
      ),
    );
  }
}

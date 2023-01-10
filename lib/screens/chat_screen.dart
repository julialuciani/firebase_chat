import 'package:firebase_chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("chat"),
          TextButton(
            onPressed: () {
              AuthMockService().logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}

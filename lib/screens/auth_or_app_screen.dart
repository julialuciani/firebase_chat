import 'package:firebase_chat/core/models/chat_user.dart';
import 'package:firebase_chat/core/services/auth/auth_mock_service.dart';
import 'package:firebase_chat/screens/auth_screen.dart';
import 'package:firebase_chat/screens/chat_screen.dart';
import 'package:firebase_chat/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ChatUser?>(
      stream: AuthMockService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          return snapshot.hasData ? const ChatScreen() : const AuthScreen();
        }
      },
    ));
  }
}

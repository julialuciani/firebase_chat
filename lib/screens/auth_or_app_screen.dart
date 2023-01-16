import 'package:firebase_chat/core/models/chat_user.dart';
import 'package:firebase_chat/screens/auth_screen.dart';
import 'package:firebase_chat/screens/chat_screen.dart';
import 'package:firebase_chat/screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else {
                return snapshot.hasData
                    ? const ChatScreen()
                    : const AuthScreen();
              }
            },
          );
        }
      },
    );
  }
}

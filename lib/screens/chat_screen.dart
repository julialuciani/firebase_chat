import 'package:firebase_chat/core/services/auth/auth_service.dart';
import 'package:firebase_chat/widgets/messages.dart';
import 'package:firebase_chat/widgets/new_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
        actions: [
          DropdownButton(
            autofocus: false,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                  value: "logout",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.indigo,
                      ),
                      SizedBox(width: 10),
                      Text("Exit")
                    ],
                  ))
            ],
            onChanged: (value) {
              if (value == "logout") {
                AuthService().logout();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Container(),
            const Expanded(child: Messages()),
            const NewMessages(),
          ],
        )),
      ),
    );
  }
}

import 'package:firebase_chat/core/services/auth/auth_service.dart';
import 'package:firebase_chat/screens/notification_screen.dart';
import 'package:firebase_chat/widgets/messages.dart';
import 'package:firebase_chat/widgets/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/auth/notifications/push_notification_service.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
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
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const NotificationScreen();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.pinkAccent,
                  child: Text(
                    "${Provider.of<ChatNotificationService>(context).itemsCount}",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          )
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //       ChatNotification(
      //         title: "Mais uma notificação",
      //         body: Random().nextDouble().toString(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

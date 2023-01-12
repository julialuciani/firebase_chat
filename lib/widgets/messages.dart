import 'package:firebase_chat/core/chat/chat_service.dart';
import 'package:firebase_chat/core/models/chat_message.dart';
import 'package:firebase_chat/core/services/auth/auth_service.dart';
import 'package:firebase_chat/widgets/message_buble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messageStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Sem mensagens por enquanto"),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (context, index) => MessageBuble(
                key: ValueKey(msgs[index].id),
                message: msgs[index],
                belongsToCurrentUser: currentUser!.id == msgs[index].userId),
          );
        }
      },
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:firebase_chat/core/chat/chat_service.dart';
import 'package:firebase_chat/core/models/chat_user.dart';
import 'package:firebase_chat/core/models/chat_message.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom diaa',
      createdAt: DateTime.now(),
      userId: "1",
      userName: "chatser",
      userImageUrl: "assets/images/avatar.png",
    ),
    ChatMessage(
      id: '1',
      text: 'Bom diaa',
      createdAt: DateTime.now(),
      userId: "1",
      userName: "chatser",
      userImageUrl: "assets/images/avatar.png",
    ),
    ChatMessage(
      id: '1',
      text: 'Bom diaa',
      createdAt: DateTime.now(),
      userId: "1",
      userName: "chatser",
      userImageUrl: "assets/images/avatar.png",
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageUrl: user.imageUrl);

    _msgs.add(newMessage);

    _controller?.add(_msgs);

    return newMessage;
  }
}

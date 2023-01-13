import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_chat/core/models/chat_message.dart';
import 'package:intl/intl.dart';

class MessageBuble extends StatelessWidget {
  static const _defaultImage = "assets/images/avatar.png";
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBuble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains("http")) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        belongsToCurrentUser
            ? const SizedBox.shrink()
            : _showUserImage(message.userImageUrl),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: belongsToCurrentUser
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
                color: belongsToCurrentUser ? Colors.indigo : Colors.pink,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(message.userName),
                  Text(message.text),
                ],
              ),
            ),
            Text(DateFormat.yMMMEd().format(message.createdAt)),
          ],
        ),
        belongsToCurrentUser
            ? _showUserImage(message.userImageUrl)
            : const SizedBox.shrink(),
      ],
    );
  }
}

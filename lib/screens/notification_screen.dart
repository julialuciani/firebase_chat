import 'package:firebase_chat/core/services/auth/notifications/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<ChatNotificationService>(context);
    final items = notificationService.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
      ),
      body: ListView.builder(
        itemCount: notificationService.itemsCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
            onTap: () {
              notificationService.remove(index);
            },
          );
        },
      ),
    );
  }
}

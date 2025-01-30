import 'package:flutter/material.dart';
import '../../database/models.dart';
import 'account_notifications.dart';

Widget getMyNotificationsScreen(BuildContext context) {
  List<DbNotification> notifications = [
    DbNotification("Hello World", "", ""),
    DbNotification("", "", ""),
    DbNotification("", "", ""),
    DbNotification("", "", ""),
  ];

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Today',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
        ),
        AccountNotifications(notifications: notifications),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Yesterday',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
        ),
        AccountNotifications(notifications: notifications),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last 7 days',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
        ),
        AccountNotifications(notifications: notifications),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:chuckler/database/models.dart';
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';

class AccountNotifications extends StatelessWidget {
  final List<DbNotification> notifications;
  const AccountNotifications({super.key, required this.notifications});

  @override
  Widget build(context) {
    print('rebuilding');
    return  Container(height: notifications.length*80, child: notifications.isNotEmpty
            ? ListView.builder(
      physics: NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.black,
                    height: 50,
                    child: const Row(
                      children: [
                        ProfilePhoto(username: "Test", img: "", radius: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Chuckler has been updated to v1.0',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 0.3, color: Colors.white,)
                ],
              );
            })
            : const Text("No notifications right now"));
  }
}

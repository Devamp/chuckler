// ignore: file_names
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final String position;
  final String username;
  final Color color;

  const CircleWidget(
      {super.key,
      required this.position,
      required this.color,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
          )),
      child: ProfilePhoto(username: username, img: "", radius: 51.0),
    );
  }
}

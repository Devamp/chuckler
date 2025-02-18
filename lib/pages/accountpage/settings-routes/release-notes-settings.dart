import 'package:flutter/material.dart';

class ReleaseNotes extends StatelessWidget {
  const ReleaseNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Release Notes'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }
}

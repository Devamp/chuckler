import 'package:flutter/material.dart';

class SecuritySettings extends StatelessWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }
}

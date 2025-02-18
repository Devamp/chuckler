import 'package:flutter/material.dart';

class SubscriptionSettings extends StatelessWidget {
  const SubscriptionSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Subscription'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }
}

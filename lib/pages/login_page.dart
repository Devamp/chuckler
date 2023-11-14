import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chuckler'),
        ),
        body: const Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            'Login Page',
            style: TextStyle(fontSize: 50),
          ),
        ])));
  }
}

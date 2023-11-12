import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuckler'),
      ),
        body: Center(
          child: Column(
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
              'First Page',
              style: TextStyle(fontSize: 50),
            ),
          ]
        )
      )
    );
    }

  }




import 'package:flutter/material.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:chuckler/CreatePageContent.dart';
import '../Session.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Chuckler'),
          titleTextStyle: const TextStyle(
              color: Color(0xFFffd230),
              fontSize: 40,
              fontWeight: FontWeight.bold),
          backgroundColor: Colors.black,
        ),
        body: CreateForm());
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex:60,
            child: CreatePageContent()
        )

      ],
    );
  }
}

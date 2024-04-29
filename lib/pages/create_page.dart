import 'package:flutter/material.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:chuckler/CreatePageContent.dart';
import '../Session.dart';



class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xff000000),
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
        //Heading
        Expanded(
          flex: 5,
          child: MainHeaderBar()
        ),
        Expanded(
          flex:60,
          child: CreatePageContent()
        )

      ],
    );
  }
}

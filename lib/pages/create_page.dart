import 'package:flutter/material.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:chuckler/CreatePageContent.dart';



class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.amber,
        body: CreateForm(),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 0));
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

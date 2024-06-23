import 'package:flutter/material.dart';
import 'package:chuckler/pages/createpage/CreatePageContent.dart';
//TODO MAKE SURE THAT CREATE PAGE DETERMINES PROMPT TYPE
//TODO CHANGE PROMPT DATA BASE LAYOUT
class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chuckler', textAlign: TextAlign.center,),
          titleTextStyle: Theme.of(context).textTheme.displayMedium,
          backgroundColor: Colors.black,
        ),
        body: CreateForm());
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});
  //TODO REPLACE WITH DYNAMIC DATA
  final postedToday = true;
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

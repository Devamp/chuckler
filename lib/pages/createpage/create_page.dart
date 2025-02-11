import 'package:flutter/material.dart';
import 'package:chuckler/pages/createpage/CreatePageContent.dart';

import '../../Theme/theme.dart';

//TODO MAKE SURE THAT CREATE PAGE DETERMINES PROMPT TYPE
//TODO CHANGE PROMPT DATA BASE LAYOUT
class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: primaryBackgroundGradient(context)),
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 10, child: CreateForm())
        ],
      ),
    );
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
      children: <Widget>[Expanded(flex: 60, child: CreatePageContent())],
    );
  }
}

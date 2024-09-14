import 'package:flutter/material.dart';
import 'package:chuckler/pages/createpage/CreatePageContent.dart';
//TODO MAKE SURE THAT CREATE PAGE DETERMINES PROMPT TYPE
//TODO CHANGE PROMPT DATA BASE LAYOUT
class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            ///
            colors: [Color.fromRGBO(9, 32, 63, 1), Color.fromRGBO(83, 120, 149, 1), Colors.black, ],
            //colors: [Color(0xff009FFF), Color(0xFFec2F4B), Colors.black, ],
            //colors: [Color(0xff355C7D), Color(0xFF6C5B7B) , Color(0xFFC06C84), Colors.black, ],
           // colors: [Color(0xffffd89b), Color(0xFF19547b), Colors.black, ],
            //colors: [Color(0xfffd746c), Color(0xFF2c3e50), Colors.black, ],
            center: Alignment(0.6, 0.5),
            radius:2,
          ),
        ),
    child:  Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 10,
            child: CreateForm())
      ],
    ),);
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

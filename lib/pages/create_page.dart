import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: CreateForm(),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 0));
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Post Promt
        Expanded(
          flex: 25,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                        heightFactor: 0.5,
                        child: Container(
                          child:Center( child: Text("The Promt will appear here\nCheck this",
                              style: TextStyle(color: Colors.white))),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black),
                        ))),
                Expanded(flex: 1, child: Container()),
              ]),
        ),
        //Text Box Container
        Expanded(
          flex: 25,
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 10)),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: "Answer Prompt Here", border: InputBorder.none),
            ),
          ),
        ),
        //Button Container
        Expanded(
            flex: 4,
            child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Expanded(
                    //Row For the Post Button
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      ElevatedButton(
                        child: Text("POST", style: TextStyle(fontSize: 30)),
                        onPressed: () {
                          print("Post Clicked");
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                      ),
                    ])))),
      ],
    );
  }
}

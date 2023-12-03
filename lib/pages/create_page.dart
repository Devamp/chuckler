import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        //Heading
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black
            )

          )
        ),
        //Post Promt
        Expanded(
          flex: 20,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 20,
                    child: FractionallySizedBox(
                        heightFactor: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black),
                          child: Center(
                              child: AutoSizeText(
                                  "Marvel should replace Captain America with _____",
                                  style: TextStyle(
                                    fontSize: 40,
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center
                              )
                          ),
                        ))),
                Expanded(flex: 1, child: Container()),
              ]),
        ),
        Expanded(
            flex: 10,
            child: Container(
                alignment: Alignment.center,
                child: Text("24:00:00 remain",
                    style: TextStyle(fontFamily: 'Livvic', fontWeight: FontWeight.w600)))),
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
                    //Row For the Post Button
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      ElevatedButton(
                        child: Text("Post", style: TextStyle(fontSize: 20, fontFamily: 'Livvic', fontWeight: FontWeight.w600)),
                        onPressed: () {
                          print("Post Clicked");
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    ]))),
      ],
    );
  }
}

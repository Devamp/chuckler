import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import 'package:chuckler/AppHeaderMain.dart';

var items = [
  "Example 1: this is what a long response to the prompt will look like...it might go on for a while this is what a long response to the prompt will look like...it might go on for a while Example 1: this is what a long response to the prompt will look like...it might go on for a while this is what a long response to the prompt will look like...it might go on for a while",
  "Example 2: short example",
];

/*
ANSWERS UNSEEN UNSEEN LIST
list - ANSWER
 */
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xff000000), body: CreateForm());
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
        Expanded(flex: 5, child: MainHeaderBar()),
        Expanded(flex: 60, child: FeedPageContent())
      ],
    );
  }
}

class FeedPageContent extends StatefulWidget {
  const FeedPageContent({super.key});

  @override
  _FeedPageContentState createState() => _FeedPageContentState();
}

class _FeedPageContentState extends State<FeedPageContent> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    print(screenWidth);
    print(screenHeight);
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: Container(
              child: Center(
                child: AutoSizeText.rich(
                  TextSpan(
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                          text: "This is where the prompt will go.",
                          style: const TextStyle(color: Color(0xFFffd230))),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 10,
                  minFontSize: 2,
                ),
              ),
            )),
        Divider(
          color: Colors.amber,
          thickness: 5,
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    UserPost(data: items[index]),
                    Container(
                      height: 20,
                    ),
                    if (index < (items.length - 1))
                      Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(height: 5, color: Colors.amber, width: screenWidth/4,),


                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                          child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text("VS",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight / 30,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "OpenSans"))),
                        ),
                                Container(height: 4, color: Colors.amber, width: screenWidth/4,),

                      ]))
                  ],
                );
              },
            ))
      ],
    );
  }
}

class UserPost extends StatelessWidget {
  final data;

  const UserPost({required this.data});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return InkWell(
        onTap: () {
          print("TAP");
        },
        onLongPress: () {
          //Display selection in modal before moving to next post
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            barrierColor: Colors.black.withOpacity(0.9),
            builder: (BuildContext context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Username",
                          style: TextStyle(
                              color: Colors.amber, fontSize: screenHeight / 20),
                        )),
                    Expanded(flex: 1, child: Container()),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              );
            },
          );
        },
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Container(width: 50, height: 50, color: Colors.amber)),
          Expanded(
            flex: 40,
            child: Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  data,
                  style: TextStyle(fontSize: screenHeight/35, fontFamily: "OpenSans", color: Colors.white),
                )),
          ),
          Expanded(
              flex: 4,
              child: IconButton(
                icon: Icon(Icons.report),
                splashRadius: 20,
                color: Colors.white,
                onPressed: () {},
              ))
        ]));
  }
}

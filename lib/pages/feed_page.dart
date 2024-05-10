import 'package:chuckler/Session.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:provider/provider.dart';

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
  /*get the prompts from the database and put them in the session*/
 void getPrompts(){
   UserService userSession = Provider.of<UserService>(context);

 }
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
                            Container(
                              height: 5,
                              color: Colors.amber,
                              width: screenWidth / 4,
                            ),
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
                            Container(
                              height: 4,
                              color: Colors.amber,
                              width: screenWidth / 4,
                            ),
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
              return CommentForm();
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
                  style: TextStyle(
                      fontSize: screenHeight / 35,
                      fontFamily: "OpenSans",
                      color: Colors.white),
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
/**
 * The following is the code for the LONG tap modal
 */
class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final myController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    myController.addListener(_checkInput);
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _checkInput() {
    setState(() {
      _hasInput = myController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 5, child: Container()),
          Expanded(
              flex: 2,
              child: Text(
                "Username",
                style:
                    TextStyle(color: Colors.white, fontSize: screenHeight / 20),
              )),
          Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(
                    minWidth: screenWidth / 1.5, maxWidth: screenWidth / 1.5),
                child: AutoSizeText.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "This is where the answer to the prompt will go for the user",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 10,
                  minFontSize: 2,
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                  minWidth: screenWidth / 1.5, maxWidth: screenWidth / 1.5),
              decoration: const BoxDecoration(
                  border: Border(
                      // top: BorderSide(color: Colors.amber, width: 2),
                      bottom: BorderSide(color: Colors.amber, width: 4))),
              child: Text(
                "Comments",
                style: TextStyle(color: Colors.amber),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(flex: 3, child: Container()),
          //Send Comment
          Expanded(
              flex: 2,
              child: Container(
                  constraints: BoxConstraints(
                      minWidth: screenWidth / 1.5, maxWidth: screenWidth / 1.5),
                  //color: Colors.white,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    focusNode: _focusNode,
                    // autofocus: true,
                    controller: myController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: _focusNode.hasFocus
                              ? Colors.amber
                              : Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Add a comment',
                      suffixIcon: _hasInput
                          ? IconButton(
                              splashRadius: 16,
                              splashColor: Colors.black,
                              icon: Icon(
                                Icons.send,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                // Handle the submit action here
                              },
                            )
                          : null,
                    ),
                  ))),
          Expanded(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      child: Text(
                        'Like Post',
                        style: TextStyle(fontSize: screenHeight / 40),
                      ),
                      style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all(
                              Size(screenWidth / 4, screenHeight / 20))),
                      onPressed: () => Navigator.pop(context)),
                  ElevatedButton(
                      child: Text('Close',
                          style: TextStyle(fontSize: screenHeight / 40)),
                      style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all(
                              Size(screenWidth / 4, screenHeight / 20))),
                      onPressed: () => Navigator.pop(context)),
                  ElevatedButton(
                      child: Text('Follow User',
                          style: TextStyle(fontSize: screenHeight / 40)),
                      style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all(
                              Size(screenWidth / 4, screenHeight / 20))),
                      onPressed: () => Navigator.pop(context)),
                ]),
          ),
          Expanded(flex: 5, child: Container()),
        ],
      ),
    );
  }
}

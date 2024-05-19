// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:chuckler/pages/createpage/create_page_loadingbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/loginpage/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import '../../Session.dart';
import 'package:provider/provider.dart';
import '../../database/models.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
import 'prompt_identifier.dart';

class CreatePageContent extends StatefulWidget {
  const CreatePageContent({super.key});

  @override
  _CreatePageContentState createState() => _CreatePageContentState();
}

class _CreatePageContentState extends State<CreatePageContent> {
  final TextEditingController _controller =
      TextEditingController(text: "Answer the Prompt Here");

//state variables
  bool isUser = false;
  String userId = "";
  String userName = "";
  String promptId = "";
  String promtDateId = "";
  String timeRemaining = "";
  List<bool> canPost = List.empty(growable: true);
  List<String> textControllerStates = List.empty(growable: true);
  var promptVal = 0;
  FocusNode focusNode = FocusNode();

  /*
  This Function sends the post to the data base with the current text
   */
  Future<void> postData() async {
    //check if user can post
    if (canPost[promptVal]) {
      //check if user has already posted
      FirebaseFirestore firebase =
          Provider.of<FirebaseFirestore>(context, listen: false);
      final docRef = await firebase
          .collection('Posts')
          .where('uid', isEqualTo: userId)
          .where('promptId', isEqualTo: promptId)
          .where('promptDateId', isEqualTo: promtDateId)
          .limit(1)
          .get();
      if (docRef.docs.isEmpty) {
        //if he/she has not already posted post
        final now = DateTime.now().toUtc();
        final timestamp = Timestamp.fromDate(now);
        CollectionReference collection = firebase.collection('Posts');
        var rng = Random();
        var random1 = rng.nextInt(pow(2, 32).toInt());
        var random2 = rng.nextInt(pow(2, 32).toInt());
        var bigRandom = (random1 << 32) | random2;
        canPost[promptVal] = false;
        return collection
            .add({
              'answer': _controller.text,
              'dislikes': 0,
              'likes': 0,
              'wins': 0,
              'uid': userId,
              'username': userName,
              'promptId': promptId,
              'random': bigRandom,
              'promptDateId': promtDateId,
              'date': timestamp
            })
            .then((value) => print("Data Added"))
            .catchError((error) => print("Failed to add data: $error"));
      } else {
        canPost[promptVal] = false;
      }
    }
  }

  /*
  This function ensures the user is logged in and establishes the userId
   */
  Future<bool> checkIfUserIsLoggedIn() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      userId = user.uid;
      return true;
    } else {
      // User is not logged in
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
    checkTheUser();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  /*
  Sets the isUser state to true if the user is logged in and false if the user is not logged int
   */
  Future<void> checkTheUser() async {
    bool theUs = await checkIfUserIsLoggedIn();
    setState(() {
      isUser = theUs;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Set variables
    UserService userSession = Provider.of<UserService>(context, listen: false);
    userName = userSession.userId!;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    List<DbPrompt> prompts = userSession.prompts!;
    promptId = prompts[promptVal].promptId!;
    promtDateId = prompts[promptVal].promptDateId!;
    for (int i = 0; i < prompts.length; i++) {
      canPost.add(true);
      textControllerStates.add("Answer the Prompt Here");
    }

    return Column(
      children: [
        //Prompt Area
        Expanded(
            flex: 55,
            child: Container(
              constraints: BoxConstraints.tight(
                  Size(screenWidth / 1.2, double.infinity)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber, width: 5)),
              child: Column(children: [
                Expanded(flex: 1, child: Container()),
                const Expanded(flex: 6, child: PromptIdentifier()),
                Expanded(
                    flex: 20,
                    child: Center(
                        child: AutoSizeText.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.normal),
                        children: <TextSpan>[
                          TextSpan(text: prompts[promptVal].before),
                          TextSpan(
                              text: _controller.text,
                              style: const TextStyle(color: Color(0xFFffd230))),
                          TextSpan(text: prompts[promptVal].after),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      minFontSize: 2,
                    ))),
                Expanded(
                    flex: 6,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  textControllerStates[promptVal] =
                                      _controller.text;
                                  if ((promptVal - 1) >= 0) {
                                    setState(() {
                                      promptVal = promptVal - 1;
                                      _controller.text =
                                          textControllerStates[promptVal];
                                    });
                                  }
                                },
                                splashRadius: 10,
                                icon: const Icon(
                                  Icons.chevron_left_outlined,
                                  color: Colors.amber,
                                ),
                              )),
                          const Expanded(
                              flex: 10, child: CreatePageLoadingBar()),
                          //PROMPT W/ USER ANSWER
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  textControllerStates[promptVal] =
                                      _controller.text;
                                  if ((promptVal + 1) < prompts.length) {
                                    setState(() {
                                      promptVal++;
                                      _controller.text =
                                          textControllerStates[promptVal];
                                    });
                                  }
                                },
                                splashRadius: 10,
                                icon: const Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.amber,
                                ),
                              )),
                        ])),
                Expanded(flex: 1, child: Container())
              ]),
            )),
        Expanded(
            flex: 35,
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                    constraints: BoxConstraints.tight(
                        Size(double.infinity, screenHeight / 3)),
                    child: Column(children: [
                      Expanded(flex: 10, child: Container()),
//Text Box Container - INPUT
                      Expanded(
                        flex: 30,
                        child: Column(children: [
                          TextField(
                            controller: _controller,
                            onTap: () {
                              if (_controller.text.trim() ==
                                  "Answer the Prompt Here") {
                                _controller.text = "";
                                setState(() {});
                              }
                            },
                            onTapOutside: (pointer) {
                              print(_controller.text.trim());
                              if (_controller.text.trim().isEmpty) {
                                _controller.text = "Answer the Prompt Here";
                                setState(() {});
                              }
                              focusNode.unfocus();
                            },
                            onChanged: (text) {
                              setState(() {});
                            },
                            maxLines: 4,
                            minLines: 1,
                            maxLength: 500,
                            keyboardType: TextInputType.multiline,
                            cursorColor: Colors.white,
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth / 1.5,
                              ),
                              hintText: "Answer Prompt Here",
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 3)),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ),
                          Container(
                              color: Colors.black,
//Row For the Post Button
                              child: ElevatedIconButton(
                                  color: Colors.amber,
                                  iconColor: Colors.black,
                                  fractionHeight: 40,
                                  text: "Post",
                                  width: screenWidth / 3,
                                  onPressed: () {
                                    if (isUser) {
                                      //Uncomment below to post data
                                      postData();
                                    } else {
                                      // User is not logged in
                                      // Show a dialog and offer to take the user back to the login screen
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title:
                                                    const Text('Not Logged In'),
                                                content: const Text(
                                                    'You cannot post unless you are logged in.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                        'Go to Login'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          SmoothPageTransition(
                                                            child: LoginPage(),
                                                          ));
                                                    },
                                                  )
                                                ]);
                                          });
                                    }
                                  }))
                        ]),
                      )
                    ])))),
      ],
    );
  }
}
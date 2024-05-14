import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/Session.dart';
import 'package:chuckler/db.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
  List<Post> items = List<Post>.empty(growable: true);
  String feedPrompt = "";
  int cPost = 0;
  bool incra = false;

  /*get the prompts from local db*/
  Future<void> getNextTwoPosts() async {
    //Access UserService
    UserService userSession = Provider.of<UserService>(context, listen: false);
    items = List<Post>.empty(growable: true);

    if ((userSession.theCurrentPostTracker! >=
            (userSession.theCurrentNumPost! - 1)) ||
        userSession.theCurrentNumPost! < 0 ||
        userSession.theCurrentPostTracker! < 0) {
      print("Getting posts from firebase ");

      //add to the session
      var getRand = userSession.prompts!.length;
      Random r = Random();
      getRand = r.nextInt(getRand);
      var i = 0;
      List<dbPost> postsFromDb = List<dbPost>.empty(growable: true);
      for (Prompt p in userSession.prompts!) {
        if (i == getRand) {
          print("THIS HAPPENED");
          print(p.promptId);
          print("promptid^");
          print(p.promptDateId);
          postsFromDb = await getPosts(firestore, p.promptId, p.promptDateId);
          print(postsFromDb.length);
          userSession.setAListOfPosts(postsFromDb);
          userSession.setTheCurrentPostTracker(0);
          userSession.setTheCurrentNumPost(postsFromDb.length);
          addPosts(postsFromDb);
          break;
        }
        i++;
      }
    }

    //Check if posts are available
    if (userSession.posts != null) {
      //take posts from session
      for (Post p in userSession.posts!) {
        if (p.postNum == userSession.theCurrentPostTracker! ||
            p.postNum == (userSession.theCurrentPostTracker! + 1)) {
          print(p.answer);
          items.add(p);
        }
      }
      userSession
          .setTheCurrentPostTracker(userSession.theCurrentPostTracker! + 2);
    }
    setState(() {});
    incrementLastPost();
  }

  @override
  void initState() {
    UserService userSession = Provider.of<UserService>(context, listen: false);
    super.initState();
    for (Post p in userSession.posts!) {
      if (p.postNum == userSession.theCurrentPostTracker! ||
          p.postNum == (userSession.theCurrentPostTracker! + 1)) {
        items.add(p);
      }
    }
    for (Prompt p in userSession.prompts!) {
      if (p.promptId == userSession.currentFeedPromptId) {
        feedPrompt = "${p.before} _____________ ${p.after}";
      }
    }
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
                          text: feedPrompt,
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
                    InkWell(
                        onTap: () async {
                          if (!incra) {
                            incra = true;
                            await getNextTwoPosts();
                            incra = false;
                          }
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
                              return CommentForm(
                                  cfData: items.elementAt(index));
                            },
                          );
                        },
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  width: 50, height: 50, color: Colors.amber)),
                          Expanded(
                            flex: 40,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Text(
                                  items.elementAt(index).answer,
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
                        ])),
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

/**class UserPost extends StatelessWidget {
    final data;

    const UserPost({required this.data, required this.getNextTwoPosts()});

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
    return CommentForm(cfData: data);
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
    data.answer,
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
    }**/

/**
 * The following is the code for the LONG tap modal
 */
class CommentForm extends StatefulWidget {
  final cfData;

  const CommentForm({required this.cfData});

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
              flex: 12,
              child: Container(
                color: Colors.black,
                  constraints: BoxConstraints.tight(Size(screenWidth/1.2,screenHeight/1.5)),
                  child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        widget.cfData.username,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: screenHeight / 20),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: screenWidth / 1.5,
                            maxWidth: screenWidth / 1.5),
                        child: AutoSizeText.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.cfData.answer,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 10,
                          minFontSize: 2,
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.amber),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.thumb_up_off_alt_rounded),
                                  ],
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.amber),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.person_add_alt_rounded,
                                  size: screenHeight / 30,
                                ),
                              )),
                        ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          minWidth: screenWidth / 1.5,
                          maxWidth: screenWidth / 1.5),
                      decoration: const BoxDecoration(
                          border: Border(
                              // top: BorderSide(color: Colors.amber, width: 2),
                              bottom:
                                  BorderSide(color: Colors.amber, width: 4))),
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
                      flex: 3,
                      child: Container(
                          constraints: BoxConstraints(
                              minWidth: screenWidth / 1.5,
                              maxWidth: screenWidth / 1.5),
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
                                  borderSide: BorderSide(
                                      color: Colors.amber, width: 2)),
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
                    flex: 1,
                    child: Container(
                        constraints: BoxConstraints.tight(
                            Size(screenWidth / 1.5, screenHeight / 30)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.close),
                            ],
                          ),
                        )),
                  ),
                ],
              ))),
          Expanded(flex: 5, child: Container()),
        ],
      ),
    );
  }
}

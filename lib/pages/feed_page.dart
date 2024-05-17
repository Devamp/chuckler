import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/Session.dart';
import 'package:chuckler/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../database/models.dart';
import '../database/isarDB.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 5, child: Container()),
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
  String feedPrompt = "";
  int cPost = 0;
  bool incra = false;

  /*get the prompts from local db*/
  Future<void> getNextTwoPosts() async {
    FirebaseFirestore firestore =
        Provider.of<FirebaseFirestore>(context, listen: false);
    //Access UserService
    UserService userSession = Provider.of<UserService>(context, listen: false);
    IsarService isarService = Provider.of<IsarService>(context, listen: false);
    List<DbPost> posts = await isarService.getTwoUnseenPosts();

    if (posts?.isEmpty ?? true) {
      print("Getting posts from firebase ");

      //add to the session
      var getRand = userSession.prompts!.length;
      Random r = Random();
      getRand = r.nextInt(getRand);
      var i = 0;
      List<DbPost> postsFromDb = List<DbPost>.empty(growable: true);
      for (DbPrompt p in userSession.prompts!) {
        if (i == getRand) {
          postsFromDb = await getPosts(firestore, p.promptId!, p.promptDateId!);
          await isarService.addPostsToDB(postsFromDb);
          posts = await isarService.getTwoUnseenPosts();
          print(posts.length);
          print("set posts");
          break;
        }
        i++;
      }
    }

    userSession.setCurrentPosts(posts);
  }

  @override
  void initState() {
    UserService userSession = Provider.of<UserService>(context, listen: false);
    if (userSession.currentPosts?.isEmpty ?? true) {
      getNextTwoPosts();
    }
    super.initState();
    for (DbPrompt p in userSession.prompts!) {
      if (p.promptId == userSession.currentFeedPromptId) {
        feedPrompt = "${p.before} _____________ ${p.after}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    UserService userSession = Provider.of<UserService>(context, listen: true);
    print(screenWidth);
    print(screenHeight);
    return Column(
      children: [
        Text(
          "Prompt",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight / 20,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w700),
        ),
        Container(
          width: screenWidth / 1.5,
          height: 4,
          decoration: BoxDecoration(color: Colors.amber),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
        Expanded(
            flex: 8,
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    screenWidth / 30, 0, screenWidth / 30, screenHeight / 40),
                decoration: BoxDecoration(
                  color: Color(0xFF383838),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 8,
                          child: Center(
                            child: AutoSizeText.rich(
                              TextSpan(
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: feedPrompt,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 10,
                              minFontSize: 2,
                            ),
                          )),
                    ]))),
        Divider(
          color: Colors.amber,
          thickness: 5,
        ),
        Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: userSession.currentPosts!.length,
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
                            builder: (context) {
                              return CommentForm(
                                      cfData: userSession.currentPosts!
                                          .elementAt(index));
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
                                  userSession.currentPosts!
                                      .elementAt(index)
                                      .answer!,
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
                    if (index < (userSession.currentPosts!.length - 1))
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
  List<DbComment> comments = List<DbComment>.empty(growable: true);

  void getPostComments() async {
    FirebaseFirestore firestore =
        Provider.of<FirebaseFirestore>(context, listen: false);
    comments = await getComments(firestore, widget.cfData.postId);
    if (comments.isEmpty) {
        comments.add(DbComment("", "No comments right now..."));
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    getPostComments();
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
    UserService userService = Provider.of<UserService>(context,listen: false);
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Container(
    constraints: BoxConstraints.tight(Size(screenWidth,screenHeight/2)),
            child: Container(
                color: Colors.black,
                constraints: BoxConstraints.tight(
                    Size(screenWidth / 1.2, screenHeight / 1.5)),
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
                                    style:
                                        const TextStyle(color: Colors.white)),
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
                                        WidgetStateProperty.all<Color>(
                                            Colors.amber),
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.black),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                        WidgetStateProperty.all<Color>(
                                            Colors.amber),
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.black),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.person_add_alt_rounded,
                                    size: screenHeight / 25,
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
                    Expanded(
                        flex: 3,
                        child: ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return Text(
                                comments[index].comment!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                                textAlign: TextAlign.center,
                              );
                            })),
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
                                          FirebaseFirestore firestore =
                                              Provider.of<FirebaseFirestore>(
                                                  context,
                                                  listen: false);
                                          addCommentToPost(
                                              firestore,
                                              widget.cfData.postId,
                                              userService.userId!,
                                              myController.text);
                                          comments.add(DbComment(
                                              "YOUR USERNAME",
                                              myController.text));
                                          myController.text = "";
                                          print(userService.userId!);
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
                                  WidgetStateProperty.all<Color>(Colors.amber),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.black),
                              shape: WidgetStateProperty.all<
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
        Container(constraints: BoxConstraints.tight(Size(screenWidth,screenHeight/4)),)

      ],
    ));
  }
}

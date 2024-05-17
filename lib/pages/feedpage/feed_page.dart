import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/Session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../database/models.dart';
import '../../database/isarDB.dart';
import 'feedpage_modal.dart';

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



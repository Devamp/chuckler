import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/Session.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../database/models.dart';
import '../../database/isarDB.dart';
import 'feedpage_modal.dart';
import 'feedpage_promptarea.dart';
import 'package:chuckler/CustomReusableWidgets/custom_text_widgets.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chuckler', textAlign: TextAlign.center,),
          titleTextStyle: const TextStyle(
              color: Color(0xFFffd230),
              fontSize: 40,
              fontWeight: FontWeight.bold),
          backgroundColor: Colors.black,
        ),
        body: const CreateForm());
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 30, child: FeedPagePromptArea()),
        Expanded(flex: 30, child: FeedPageContent())
      ],
    );
  }
}

class FeedPageContent extends StatelessWidget {
  const FeedPageContent({super.key});

  /*get the prompts from local db*/
  Future<void> getNextTwoPosts(context) async {
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
          print("set posts");
          break;
        }
        i++;
      }
    }

    userSession.setCurrentPosts(posts);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =  MediaQuery.of(context).size.height;
    UserService userSession = Provider.of<UserService>(context, listen: true);
    print(userSession.currentPosts!.length);
    print("Rebuilding");
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: userSession.currentPosts!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                        onTap: () async {
                          await getNextTwoPosts(context);
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
                              return CommentModal(
                                  cfData: userSession.currentPosts!
                                      .elementAt(index), screenWidth: screenWidth, screenHeight: screenHeight);
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
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: OpenSansText(
                                    text: userSession.currentPosts!
                                        .elementAt(index)
                                        .answer!,
                                    fractionScreenHeight: 35,
                                    color: Colors.white,
                                    fw: FontWeight.normal,
                                  ))),
                          Expanded(
                              flex: 4,
                              child: IconButton(
                                icon: const Icon(Icons.report),
                                splashRadius: 20,
                                color: Colors.white,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(20))),
                                          backgroundColor: const Color.fromARGB(255, 20, 20, 20),
                                          title: const Text('Confirmation'),
                                          titleTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFffd230),
                                              fontSize: 22),
                                          content: const Text('Are you sure you want to report this post?'),
                                          contentTextStyle: const TextStyle(
                                              fontSize: 14, color: Colors.white),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  backgroundColor: const Color(0xFFffd230)),
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: Colors.white,
                                              ),
                                              child: const Text('Yes'),
                                              onPressed: () async {

                                                //TODO ADD REPORTED FUNCTIONALLITY
                                               print("Reported");
                                               Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
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
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                                child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: const OpenSansText(
                                        text: "VS",
                                        fractionScreenHeight: 30,
                                        color: Colors.black,
                                        fw: FontWeight.w700))),
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

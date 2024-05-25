import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
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
import 'no_user_post.dart';

class FeedPage extends StatelessWidget {
  FeedPage({super.key});

  //TODO REPLACE WITH DYNAMIC DATA
  final havePosted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chuckler',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: Theme.of(context).textTheme.displayMedium,
          backgroundColor: Colors.black,
        ),
        body: havePosted ? const CreateForm() : const NoUserPost());
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 20, child: FeedPagePromptArea()),
        Expanded(flex: 30, child: FeedPageContent())
      ],
    );
  }
}

class FeedPageContent extends StatelessWidget {
  FeedPageContent({super.key});

  final List<MaterialAccentColor> userColors = [
    Colors.greenAccent,
    Colors.purpleAccent
  ];

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
    final screenHeight = MediaQuery.of(context).size.height;
    UserService userSession = Provider.of<UserService>(context, listen: true);
    print(userSession.currentPosts!.length);
    print("Rebuilding");
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
                width: screenWidth / 1.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Username1",
                                style: TextStyle(
                                    color: userColors[0],
                                    fontFamily: "Livvic",
                                    fontSize: screenHeight / 30,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: " VS ",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontFamily: "Livvic",
                                    fontSize: screenHeight / 30,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: "Username2 ",
                                style: TextStyle(
                                    color: userColors[1],
                                    fontFamily: "Livvic",
                                    fontSize: screenHeight / 30,
                                    fontWeight: FontWeight.w600))
                          ]))),
                      Divider(
                        thickness: 3,
                        color: Colors.white54,
                      ),
                      Expanded(
                          child: Container(
                              child: ListView.builder(
                        itemCount: userSession.currentPosts!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      barrierColor:
                                          Colors.black.withOpacity(0.9),
                                      builder: (context) {
                                        return CommentModal(
                                            cfData: userSession.currentPosts!
                                                .elementAt(index),
                                            screenWidth: screenWidth,
                                            screenHeight: screenHeight);
                                      },
                                    );
                                  },
                                  child: Container(
                                      height: screenHeight / 8,
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: 50,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: userColors[index],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )),
                                        Expanded(
                                            flex: 40,
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: OpenSansText(
                                                  text: userSession
                                                      .currentPosts!
                                                      .elementAt(index)
                                                      .answer!,
                                                  fractionScreenHeight: 35,
                                                  color: userColors[index],
                                                  fw: FontWeight.normal,
                                                ))),
                                        Expanded(
                                            flex: 4,
                                            child: IconButton(
                                              icon: const Icon(Icons.report),
                                              splashRadius: 20,
                                              color: Colors.white,
                                              onPressed: () {},
                                            ))
                                      ]))),
                              index < (userSession.currentPosts!.length - 1)
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      height: 2.0,
                                      // Height of the divider
                                      width: double.infinity,
                                      // Full width
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: userColors,
                                          // Gradient colors
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ))),
                      Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Center(heightFactor: 2, child: ChangingButton(
                              index: 0,
                              icons: [Icons.favorite_border, Icons.favorite],
                              pressed: () {
                                return 1;
                              }))),
                          Expanded(child: ElevatedIconButton(color: Colors.amber, iconColor: Colors.black, fractionHeight: 25, icon: Icons.comment)),
                          Expanded(child: Center(heightFactor: 2, child: ChangingButton(
                              index: 0,
                              icons: [Icons.heart_broken_outlined, Icons.heart_broken],
                              pressed: () {
                                return 1;
                              }))),
                        ],
                      ))
                    ])))
      ],
    ));
  }
}

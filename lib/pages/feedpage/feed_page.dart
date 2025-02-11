import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
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
import 'matchup.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  //TODO REPLACE WITH DYNAMIC DATA
  final havePosted = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(9, 32, 63, 1),
              Color.fromRGBO(83, 120, 149, 1),
              Colors.black,
            ],
            center: Alignment(0.6, 0.5),
            radius: 2,
          ),
        ),
        child: Column(
          children: [
            Expanded(flex: 2, child: Container(
              alignment: Alignment.bottomLeft,
              child: DropdownButtonExample(),
            )),
            Expanded(
                flex: 15,
                /// havePosted ? const CreateForm() :
                child:havePosted ? const CreateForm() :  const NoUserPost())
          ],
        ));
  }
}

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[Expanded(flex: 30, child: FeedPageContent())],
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

    if (posts.isEmpty ?? true) {
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
    userSession.setCurrentFeedPromptId(posts.first.promptId!);
    userSession.setCurrentPosts(posts);
  }

  /*Get the user information for the modal*/
  Future<DbUser?> getModalUser(context, String uid) async {
    FirebaseFirestore firestore =
        Provider.of<FirebaseFirestore>(context, listen: false);
    IsarService isarService = Provider.of<IsarService>(context, listen: false);
    UserService userSession = Provider.of<UserService>(context, listen: false);
    DbUser? user = await isarService.getUserFromDb(uid);
    user ??= await getAUser(firestore, uid);
    if (user != null) {
      if (userSession.loggedInUser!.friends.isNotEmpty) {
        if (userSession.loggedInUser!.friends.contains(user.uid!)) {
          user.friend = true;
        }
      }
      if (userSession.loggedInUser!.pendingFriends.isNotEmpty) {
        if (userSession.loggedInUser!.pendingFriends.contains(user.uid!)) {
          user.pendingFriend = true;
        }
      }
      isarService.addUserToDb(user);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    UserService userSession = Provider.of<UserService>(context, listen: true);
    print(userSession.currentPosts!.length);
    print("Rebuilding");
    return Container(
      width: screenWidth/1.1,
        decoration: BoxDecoration(color: Colors.black54),
        child: ListView.builder(
          shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return  MatchupTemplate();
        }));
  }
}

/** DROP DOWN MENU */
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static List<String> list = <String>['Global', 'Local', 'Friends', 'Create+'];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
      underline: Container(),
      dropdownColor: Colors.white70,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

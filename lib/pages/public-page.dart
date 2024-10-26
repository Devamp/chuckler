import 'package:chuckler/pages/accountpage/account_awards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RenderPost extends StatelessWidget {
  final String postText;

  const RenderPost({
    Key? key,
    required this.postText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Spacing between posts
      padding: const EdgeInsets.all(15), // Padding inside the post container
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the post
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        postText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}


class AwardContainer extends StatelessWidget {
  final FaIcon awardIcon;
  final String awardText;
  final bool isComplete;
  final String awardDescription;

  const AwardContainer({
    Key? key,
    required this.awardIcon,
    required this.awardText,
    required this.isComplete,
    required this.awardDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125, 
      height: 150, 
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.black], // Customize your flag colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Award(awardIcon: awardIcon, awardText: awardText, isComplete: isComplete, awardDescription: awardDescription)
        ],
      ),
    );
  }
}


class PublicPage extends StatelessWidget {
  final String username;

  const PublicPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(  // Make the entire body scrollable
        child: Column(
          children: [
            publicPageHeader(context),
            publicPageBody(context),
          ],
        ),
      ),
    );
  }
}

Widget publicPageHeader(BuildContext context) {
  return Container(
    color: Colors.black,
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        const ProfilePicture(
            name: AutofillHints.username, radius: 55, fontsize: 20),
        const SizedBox(height: 12),
        const Text(
          AutofillHints.username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3928',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Posts',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4.2K',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Friends',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3.9M',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Likes',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            print("Clicked");
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.userPlus,
                color: Colors.black,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Follow',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget publicPageBody(BuildContext context) {
  return Container(
    color: Colors.black,
    child: Center(
      child: Column(
        children: [
          const SizedBox(height: 5,),
          achivementsContainer(context),
          const SizedBox(height: 5,),
          postsContainer(context)
        ],
      ),
    ),
  );
}

Widget achivementsContainer(BuildContext context) {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Expanded(
        child: Row(
          children: [
            AwardContainer(
              awardIcon: FaIcon(FontAwesomeIcons.userGroup),
              awardText: '100 Friends',
              isComplete: true,
              awardDescription: 'Make 100 friends.',
            ),
            SizedBox(width: 20,),
            AwardContainer(
              awardIcon: FaIcon(FontAwesomeIcons.fire, size: 52,),
              awardText: 'Streaker',
              isComplete: true,
              awardDescription:
                  'Log into your account for 30 consecutive days.',
            ),
            SizedBox(width: 20,),
            AwardContainer(
              awardIcon: FaIcon(FontAwesomeIcons.heart),
              awardText: '1000 Likes',
              isComplete: true,
              awardDescription: 'Achieve a total of 1000 likes.',
            ),
            SizedBox(width: 20,),
            AwardContainer(
              awardIcon: FaIcon(FontAwesomeIcons.percent),
              awardText: 'The 1%',
              isComplete: true,
              awardDescription: 'Be in the top 1% of posters.',
            ),
          ],
        ),
      ),
    ),
  );
}

Widget postsContainer(BuildContext context) {
  return const SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RenderPost(postText: "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS..."),
        RenderPost(postText: "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS..."),
        RenderPost(postText: "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS..."),
        RenderPost(postText: "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS..."),
        RenderPost(postText: "THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS...THIS IS SOME TEXT TO SEE HOW IT WILL FIT IN THIS..."),
      ],
    ),
  );
}


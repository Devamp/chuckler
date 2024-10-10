import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:chuckler/pages/accountpage/account_awards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublicPage extends StatelessWidget {
  final String username;

  const PublicPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePhoto(username: username, img: '', radius: 70),
                  const SizedBox(height: 10),
                  Text(
                    username.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.amber,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.amber, width: 3),
                        ),
                      ),
                      onPressed: () {
                        // Action to perform when the button is pressed
                      },
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.userPlus),
                            SizedBox(width: 5),
                            Text(
                              'Add Friend',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Achievements',
                      style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 28),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Award(
                              awardIcon:
                                  FaIcon(FontAwesomeIcons.fire, size: 80),
                              awardText: '',
                              isComplete: true,
                              awardDescription:
                                  'Log into your account for 30 consecutive days.',
                            ),
                          ),
                          SizedBox(width: 50),
                          Center(
                            child: Award(
                              awardIcon:
                                  FaIcon(FontAwesomeIcons.comment, size: 80),
                              awardText: '',
                              isComplete: true,
                              awardDescription: 'Leave a comment 100 times.',
                            ),
                          ),
                          SizedBox(width: 50),
                          Center(
                            child: Award(
                              awardIcon: FaIcon(
                                  FontAwesomeIcons.solidNoteSticky,
                                  size: 80),
                              awardText: '',
                              isComplete: true,
                              awardDescription: 'Add 5 friends.',
                            ),
                          ),
                          SizedBox(width: 50),
                          Center(
                            child: Award(
                              awardIcon:
                                  FaIcon(FontAwesomeIcons.thumbsUp, size: 80),
                              awardText: '',
                              isComplete: true,
                              awardDescription: 'Add 5 friends.',
                            ),
                          ),
                          SizedBox(width: 50),
                          Center(
                            child: Award(
                              awardIcon:
                                  FaIcon(FontAwesomeIcons.gasPump, size: 80),
                              awardText: '',
                              isComplete: true,
                              awardDescription: 'Add 5 friends.',
                            ),
                          ),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Award extends StatelessWidget {
  final awardIcon;
  final String awardText;
  final bool isComplete;
  final String awardDescription;

  const Award(
      {super.key,
      required this.awardIcon,
      required this.awardText,
      required this.isComplete,
      required this.awardDescription});

  @override
  Widget build(BuildContext context) {
    Color awardColor = Colors.white;

    if (isComplete) {
      awardColor = Colors.amber;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 55,
          child: IconButton(
            icon: awardIcon,
            color: awardColor,
            iconSize: 35,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: SizedBox(
                      height: 300,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
                        title: Center(
                          child: Text(awardText),
                        ),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFffd230),
                            fontSize: 25),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.fire,
                              size: 32,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              awardDescription,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        contentTextStyle:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        actions: [
                          Center(
                            // Center the action button
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFffd230)),
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Text(
          awardText,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
        )
      ],
    );
  }
}

class AwardsPage extends StatelessWidget {
  const AwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.userGroup),
                    awardText: '100 Friends',
                    isComplete: false,
                    awardDescription: 'Make 100 friends.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.fire),
                    awardText: 'Streaker',
                    isComplete: true,
                    awardDescription:
                        'Log into your account for 30 consecutive days.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.solidNoteSticky),
                    awardText: '100 Posts',
                    isComplete: true,
                    awardDescription: 'Make 100 total posts.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.comment),
                    awardText: '100 Comments',
                    isComplete: false,
                    awardDescription: 'Leave a comment 100 times.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.one),
                    awardText: 'First Post',
                    isComplete: true,
                    awardDescription: 'Make your first post.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.heart),
                    awardText: '1000 Likes',
                    isComplete: false,
                    awardDescription: 'Achieve a total of 1000 likes.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.trophy),
                    awardText: 'Leaderboard',
                    isComplete: true,
                    awardDescription: 'Secure a spot on the leaderboard.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.percent),
                    awardText: 'The 1%',
                    isComplete: true,
                    awardDescription: 'Be in the top 1% of posters.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.handshakeAngle),
                    awardText: 'Refer A Friend',
                    isComplete: true,
                    awardDescription: 'Refer a friend to join Chucker.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Award(
                    awardIcon: FaIcon(FontAwesomeIcons.circleQuestion),
                    awardText: '',
                    isComplete: false,
                    awardDescription: 'Hidden Achievement.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

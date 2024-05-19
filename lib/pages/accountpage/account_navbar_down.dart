
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPageContent extends StatefulWidget {
  AccountPageContent({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPageContent> {
  String username = "Caden";
  int followers = 0;
  int following = 0;
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _firstTime = true;
  Widget currentScreen = Container();

  @override
  Widget build(BuildContext context) {
    Widget bar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.sticky_note_2),
          label: 'My Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmarks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        // Handle navigation based on index
        switch (index) {
          case 0:
            setState(() {
              currentScreen = getMyPostsScreen(context);
            });
            break;
          case 1:
            setState(() {
              currentScreen = SingleChildScrollView(
                child: Container(
                  height: 1000.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: const Text('My Bookmarks'),
                      )
                    ],
                  ),
                ),
              );
            });
            break;
          case 2:
            setState(() {
              currentScreen = getMyNotificationsScreen(context);
            });
            break;

        }
      },
    );

    if (_firstTime) {
      setState(() {
        currentScreen = getMyPostsScreen(context);
      });

      _firstTime = false;
    }
    return Column(children: [bar,currentScreen],);
  }

  Widget getMyPostsScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 150,
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'This is a sample post and it can be really long depending on the day YOUR ANSWER HERE!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black,
            height: 150,
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    color: Colors.brown[600],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'ANOTHER REALLY LONGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG POST IDK HOW THIS WILL FIT LETS SEE WOOOHOOO!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black,
            height: 150,
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'LETS TEST IF THE SCROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOLING WORKS!!!! WOOO GOOO 2ND PLACE SILVER BAR....',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black,
            height: 150,
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'Another small test of a post getting 1st place!!!!!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTodaysEvents(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: "Chuckler",
              radius: 20,
              fontsize: 20,
              random: true,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Don\'t miss today\'s prompt! 1 hour remaining!',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'Devam',
              radius: 20,
              fontsize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Devam Patel liked your Post!',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'Alice',
              radius: 20,
              fontsize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Check out Alice\'s new post!',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  Widget getYesterdaysEvents(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'C',
              radius: 20,
              fontsize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Chuckler has been updated to v1.0',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  Widget getLastWeeksEvents(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'Caden',
              radius: 20,
              fontsize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Caden started following you.',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'Chuckler',
              radius: 20,
              fontsize: 20,
              random: true,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Devam, your latest post is getting hits!',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.black,
        height: 50,
        child: const Row(
          children: [
            ProfilePicture(
              name: 'Megan',
              radius: 20,
              fontsize: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Megan left a comment on your post.',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  Widget getMyNotificationsScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Today',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
          getTodaysEvents(context),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Yesterday',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
          getYesterdaysEvents(context),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Last 7 days',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
          getLastWeeksEvents(context)
        ],
      ),
    );
  }



}
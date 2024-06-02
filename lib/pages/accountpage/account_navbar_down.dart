
import 'package:chuckler/pages/accountpage/account_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account_posts.dart';
import 'package:chuckler/database/models.dart';

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
  List<DbNotification> notifications = [DbNotification("", "", ""), DbNotification("", "", ""),DbNotification("", "", ""),DbNotification("", "", ""),];
  //TODO INSTANTIATE POSTS WITH REAL DATA
  List<DbPost> posts = [DbPost("a","b","c", "C", 0, 0, 0,"",""), DbPost("a","b","c", "C", 0, 0, 0,"",""), DbPost("a","b","c", "C", 0, 0, 0,"",""), DbPost("a","b","c", "C", 0, 0, 0,"",""), ];
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
    return AccountPosts(posts: posts);

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
           AccountNotifications( notifications:notifications),
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
          AccountNotifications( notifications:notifications),

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
          AccountNotifications(notifications:notifications),

        ],
      ),
    );
  }



}
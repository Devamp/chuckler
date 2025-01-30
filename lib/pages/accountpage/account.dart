import 'package:chuckler/pages/accountpage/account_awards.dart';
import 'package:chuckler/pages/accountpage/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import '../../Theme/theme.dart';
import '../../database/models.dart';
import 'account_posts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _currentPageIndex = 0;
  Widget _currentScreen = Container();

  List<DbPost> posts = [
    DbPost("a", "b", "c", "C", 0, 0, 0, "", ""),
    DbPost("a", "b", "c", "C", 0, 0, 0, "", ""),
    DbPost("a", "b", "c", "C", 0, 0, 0, "", ""),
    DbPost("a", "b", "c", "C", 0, 0, 0, "", ""),
  ];

  void setCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: primaryBackgroundGradient(context),
        ),
        child: Column(
          children: [
            accountHeader(
                context, setCurrentPageIndex, screenWidth, screenHeight),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: _currentScreen))
          ],
        ),
      ),
    );
  }

  Widget accountHeader(BuildContext context, Function setCurrentPageIndex,
      double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.45,
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfilePicture(name: 'Username', radius: 55, fontsize: 20),
            const SizedBox(height: 12),
            const Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      style: TextStyle(fontSize: 16, color: Colors.amber),
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
                      style: TextStyle(fontSize: 16, color: Colors.amber),
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
                      style: TextStyle(fontSize: 16, color: Colors.amber),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            buildNavBar(context, setCurrentPageIndex),
          ],
        ),
      ),
    );
  }

  Widget buildNavBar(BuildContext context, Function setCurrentPageIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      currentIndex: _currentPageIndex,
      onTap: (itemIndex) {
        setCurrentPageIndex(itemIndex);

        // Handle navigation based on index
        switch (itemIndex) {
          case 0:
            setState(() {
              _currentScreen = AccountPosts(posts: posts);
            });
            break;
          case 1:
            setState(() {
              _currentScreen = const SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      Text('My Bookmarks'),
                    ],
                  ),
                ),
              );
            });
            break;
          case 2:
            setState(() {
              _currentScreen = getMyNotificationsScreen(context);
            });
            break;

          case 3:
            setState(() {
              _currentScreen = AwardsPage();
            });
            break;
        }
      },
      selectedItemColor: const Color(0xFFffd230),
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          label: "Posts",
          icon: Icon(Icons.sticky_note_2_outlined),
        ),
        BottomNavigationBarItem(label: "Bookmarks", icon: Icon(Icons.bookmark)),
        BottomNavigationBarItem(
          label: "Notifications",
          icon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          label: "Achievements",
          icon: Icon(Icons.verified_rounded),
        ),
      ],
    );
  }
}

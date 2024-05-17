// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

//import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Session.dart';

//test

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = "";
  int followers = 0;
  int following = 0;
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _firstTime = true;
  Widget currentScreen = Container();

  Widget header(BuildContext context) {
    void signout() async {
      _auth.signOut();
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ProfilePicture(
                    name: username,
                    radius: 50,
                    fontsize: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 220,
            width: 230,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          following.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          followers.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // confirm the user wants to log out
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: Color.fromARGB(255, 20, 20, 20),
                            title: const Text('Confirmation'),
                            titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFffd230),
                                fontSize: 22),
                            content: Text('Are you sure you want to sign out?'),
                            contentTextStyle: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color(0xFFffd230)),
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                                child: Text('Yes'),
                                onPressed: () async {
                                  UserService userSession = Provider.of<UserService>(context, listen: false);
                                  userSession.logout();
                                  await _auth.signOut();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout_outlined),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFffd230)),
                    iconColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getMyPostsScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 10.0),
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
          SizedBox(
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
          SizedBox(
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
          SizedBox(
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
        child: Row(
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
        child: Row(
          children: [
            ProfilePicture(
              name: username,
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
        child: Row(
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
        child: Row(
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
        child: Row(
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
        child: Row(
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
        child: Row(
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
            child: Text(
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
            child: Text(
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
            child: Text(
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

  Widget navBar(BuildContext context) {
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
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
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
                        child: Text('My Bookmarks'),
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
          case 3:
            currentScreen = SingleChildScrollView(
              child: Container(
                height: 1000.0,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Text('My Profile'),
                    )
                  ],
                ),
              ),
            );
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
    return bar;
  }

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context);

    if (userSession.userId != null) {
      username = userSession.userId!;
      followers = userSession.followers!;
      following = userSession.following!;

      return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [header(context), navBar(context), currentScreen],
            ),
          ));
    } else {
      // If no user is logged in, redirect to the login page
      //Post frame call back actually the current build to finish before calling Navigator
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Container(); // Placeholder widget; This will be visible for a second
    }
  }
}

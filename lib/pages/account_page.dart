// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

//import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/globalvars.dart';
import '../Session.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = "";
  int followers = 0;
  int following = 0;
  int currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget header(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context);
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
                  onPressed: () async {
                    await _auth.signOut();
                    userSession.logout();

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

  Widget navBar(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
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
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // Handle navigation based on index
          switch (index) {
            case 0:
              // Navigate to My Posts page or perform related action
              break;
            case 1:
              // Navigate to Search page or perform related action
              break;
            case 2:
              // Navigate to Favorites page or perform related action
              break;
            case 3:
              // Navigate to Profile page or perform related action
              break;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context);

    if (userSession.userId != null) {
      username = userSession.userId!;
      followers = userSession.followers!;
      following = userSession.following!;

      return Scaffold(
        backgroundColor: const Color(0xFFffd230),
        body: SingleChildScrollView(
          child: Column(
            children: [header(context), navBar(context)],
          ),
        )
      );
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

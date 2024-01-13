// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';
import '../Session.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  String username = "";
  int followers = 0;
  int following = 0;

  Widget header(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                ),
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
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
              ),
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
                    print('Edit Profile Clicked');
                  },
                  icon: Icon(Icons.settings),
                  label: Text(
                    'Edit Profile',
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

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context);

    if (userSession.userId != null) {
      username = userSession.userId!;
      followers = userSession.followers!;
      following = userSession.following!;

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(context),
              // Add more widgets as needed
            ],
          ),
        ),
        backgroundColor: const Color(0xFFffd230),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 3),
      );
    } else {
      // If no user is logged in, redirect to the login page
      Navigator.pushReplacementNamed(context, '/login');
      return Container(); // Placeholder widget; it won't be visible
    }
  }
}

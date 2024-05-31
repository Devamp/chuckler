// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

//import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Session.dart';
import 'profile_photo_picker_modal.dart';
import 'account_navbar_down.dart';

class  AccountPage extends StatelessWidget{
   AccountPage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context);

    if (userSession.loggedInUser!.username != null) {
      //username = userSession.userId!;
    //  followers = userSession.followers!;
      //following = userSession.following!;

      return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [header(context), AccountPageContent()],
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

  Widget header(BuildContext context) {
    UserService userService = Provider.of<UserService>(context, listen: true);
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
                  ProfilePhotoPickerModal(username: userService.loggedInUser!.username!, img: userService.loggedInUser!.profilePicture),
                  Text(
                    userService.loggedInUser!.username!,
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
                          userService.loggedInUser!.numFriends.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userService.loggedInUser!.numPosts!.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFffd230)),
                    iconColor: WidgetStateProperty.all<Color>(Colors.black),
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



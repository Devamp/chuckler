// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Session.dart';
import 'package:provider/provider.dart';
import '../DatabaseQueries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db.dart';
import 'dart:math';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String inputEmail = '';
  String inputPassword = '';
  String resetEmail = '';
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> verifyLogin(email, password, context) async {
    User user;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user!;
      await setupUserSession(context, user.uid);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  /**
   * Get the initial posts
   */
  Future<void> getInitialPosts(context, FirebaseFirestore firestore,
      String prmtId, String prmtDateId) async {
    //instance of usersession
    final UserService userSession =
        Provider.of<UserService>(context, listen: false);
    //check if posts are in local database
    List<dbPost> posts = await getLocalPosts();
    //make sure we are not already finished looking at all of the posts
    int? numP = await getNumPosts();
    int? onP = await getCurrentPost();
    bool runGetNew = false;
    if (numP != null && onP != null) {
      print("NUM P " + numP.toString());
      print("on P " + onP.toString());
      if ((onP >= (numP - 1)) || onP < 0 || numP <= 0) {
        runGetNew = true;
      }
    } else {
      runGetNew = true;
    }
    //get new posts from firebase
    if (posts.isEmpty || runGetNew) {
      print("running firebase retrieval");
      posts = await getPosts(firestore, prmtId, prmtDateId);

      addPosts(posts);
      userSession.setTheCurrentNumPost(posts.length);
      userSession.setTheCurrentPostTracker(0);
    } else {
      userSession.setTheCurrentNumPost(numP!);
      userSession.setTheCurrentPostTracker(onP!);
    }
    print("POSTS");
    print(posts.length);
    for (dbPost p in posts) {
      userSession.addPost(p);
    }
  }

  Future<void> setupUserSession(context, userId) async {
    print(userId + "This is the userID");
    final UserService userSession =
        Provider.of<UserService>(context, listen: false);

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Users')
          .where('userID', isEqualTo: userId)
          .get();
      List<dbPrompt> promptsToAdd = List<dbPrompt>.empty(growable: true);
      //check if user has already logged in
      if (await firstLoginToday()) {
        //if so get stored prompts
        promptsToAdd = await getPrompts();
        if (promptsToAdd.isNotEmpty) {
          print("getting prompts from db");
        }
      }
      //if nothing is stored move on
      if (promptsToAdd.isEmpty) {
        promptsToAdd = await getDailyPrompts(firestore);
        if (querySnapshot.docs.isEmpty) {
          print("NO DOCS FOUND " + userId);
        } else {
          addPrompts(promptsToAdd);
          print("added prompts");
        }
      }
      //add to the session
      var getRand = promptsToAdd.length;
      Random r = Random();
      getRand = r.nextInt(getRand);
      print("randomnum");
      print(getRand);
      var i = 0;
      for (Prompt p in promptsToAdd) {
        if (i == getRand) {
          print("prompt");
          print(p.promptId);
          print(p.promptDateId);
          userSession.setCurrentFeedPromptId(p.promptId);
          await getInitialPosts(context, firestore, p.promptId, p.promptDateId);
        }
        userSession.addPrompt(p);
        i++;
      }

      QueryDocumentSnapshot doc = querySnapshot.docs.first;

      dynamic saved_user = doc.id;
      dynamic saved_followers = doc.get(FieldPath(['followers']));
      dynamic saved_following = doc.get(FieldPath(['following']));

      userSession.setUserId(saved_user);
      userSession.setFollowers(saved_followers);
      userSession.setFollowing(saved_following);
      String? lTime = await getCachedLoginTime();
      userSession.setLoginTime(lTime);
      if (!userSession.firstLogin) {
        print("last login " + userSession.logTime!);
      }
      cacheLoginTime();
    } catch (e) {
      print('Error: $e');
    }
  }

  void showForgotPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Reset Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.lock,
                    size: 52, // Adjust the size as needed
                    color: const Color(0xFFffd230),
                  ),
                ),

                SizedBox(
                    height:
                        20), // Adjust the spacing between logo and other content

                Text(
                  'Enter your email and we will send you a rest link',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    resetEmail = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.sendPasswordResetEmail(email: resetEmail);
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFffd230)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text('Submit Request'),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFffd230),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 5.0,
                      ),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 150,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/Chuckler-logo-circle.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (text) {
                      inputEmail = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      inputPassword = text;
                    },
                    obscureText: true, // for password
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showForgotPasswordSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 75, 75, 75)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFffd230)),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.assignment_add),
                            SizedBox(width: 8.0),
                            Text('Sign Up'),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () async {
                          if (isLoading.value) {
                            return;
                          }
                          isLoading.value = true;
                          bool status = await verifyLogin(
                              inputEmail, inputPassword, context);
                          isLoading.value = false;
                          if (status) {
                            Navigator.pushReplacementNamed(context, '/app');
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Verification Failed"),
                                  content: Text(
                                      "Invalid email or password. Please try again."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, value, child) {
                            return value ? CircularProgressIndicator() : child!;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.login_sharp),
                              SizedBox(width: 8.0),
                              Text('Login'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print("Guest Clicked");
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(10.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person),
                        SizedBox(width: 8.0),
                        Text(
                          'CONTINUE AS GUEST',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

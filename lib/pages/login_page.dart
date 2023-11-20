// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String inputEmail = '';
  String inputPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFffd230),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        color: Colors.white,
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
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    print("Forgot Password Clicked");
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(10.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.assignment_add),
                          SizedBox(width: 8.0),
                          Text('SIGN UP'),
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: inputEmail, password: inputPassword);

                          Navigator.pushNamed(context, '/feed');
                        } catch (e) {
                          String errorMessage = e.toString();

                          int startIndex = errorMessage.indexOf(']');
                          String endMessage =
                              errorMessage.substring(startIndex + 1).trim();

                          if (errorMessage
                              .contains("INVALID_LOGIN_CREDENTIALS")) {
                            endMessage = "Invalid user or password.";
                          }
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Failure'),
                                content: Text(endMessage),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok'),
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
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(10.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.login_sharp),
                          SizedBox(width: 8.0),
                          Text('LOGIN'),
                        ],
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
    );
  }
}

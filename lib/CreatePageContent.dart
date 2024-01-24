import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';

class CreatePageContent extends StatefulWidget {
  const CreatePageContent({super.key});

  @override
  _CreatePageContentState createState() => _CreatePageContentState();
}

class _CreatePageContentState extends State<CreatePageContent> {

  final TextEditingController _controller =
      TextEditingController(text: "Answer the Prompt Here");

  String beforeAnswer = "";
  String afterAnswer = "";
  bool isUser = false;
  String promptId ="";
  String userId ="";
  String userName = "";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /*
  Gets the current prompt and returns a Map {'Before': 'content before prompt', 'After': 'Content after prompt'}
   */
  Future<Map<String, dynamic>> getTodaysPrompt() async {
    DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 8));
    DateTime today = DateTime(now.year, now.month, now.day);

    // Create timestamps for the start and end datess
    Timestamp startDate = Timestamp.fromDate(today);
    Timestamp endDate =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day + 1));
    // Fetch the document
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Prompts')
        .where('promptDate', isGreaterThanOrEqualTo: startDate)
        .where('promptDate', isLessThan: endDate)
        .get();

    // Check if a document was found
    if (snapshot.docs.isNotEmpty) {
      // Get the prompt from the first document
      Map<String, dynamic> data = snapshot.docs.first.data();
      if (data.containsKey('Before') && data.containsKey('After')) {
        return {'Before': data['Before'], 'After': data['After'], 'id': snapshot.docs.first.id};
      } else {
        throw Exception('Error: Document does not contain a "prompt" field');
      }
    } else {
      throw Exception('Error: No document found for the given date');
    }
  }

  /*
  This Function sends the post to the bata base with the current text
   */
  Future<void> postData() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('Posts');
    return collection
        .add({
      'commentIds': [], // Field
      'content': _controller.text,
      'dislikedUserIds': [],
      'likedUserIds': [],
      'promptId': promptId,
      'userId': userId
    })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data: $error"));
  }

  /*
  This function ensures the user is logged in and establishes the userId
   */
  Future<bool> checkIfUserIsLoggedIn() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      userId = user.uid;
      return true;

    } else {
      // User is not logged in
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadPromptData();
    checkTheUser();
  }
/*
 Sets prompt state
 */
  Future<void> loadPromptData() async {
    Map<String, dynamic> promptData = await getTodaysPrompt();
    setState(() {
      beforeAnswer = promptData['Before'];
      afterAnswer = promptData['After'];
      promptId = promptData['id'];
    });
  }
  /*
  Sets the isUser state to true if the user is logged in and false if the user is not logged int
   */
  Future<void> checkTheUser() async {
    bool theUs = await checkIfUserIsLoggedIn();
    setState(() {
      isUser = theUs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 20,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                //PROMPT W/ USER ANSWER
                Expanded(
                    flex: 20,
                    child: FractionallySizedBox(
                        heightFactor: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black),
                          child: Center(
                              child: AutoSizeText.rich(
                            TextSpan(
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(text: beforeAnswer),
                                TextSpan(
                                    text: _controller.text,
                                    style: const TextStyle(color: Colors.amber)),
                                TextSpan(text: afterAnswer),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            minFontSize: 2,
                          )),
                        ))),
                Expanded(flex: 1, child: Container()),
              ]),
        ),
        Expanded(
            flex: 10,
            child: Container(
                alignment: Alignment.center,
                child: const Text("24:00:00 Remaining",
                    style: TextStyle(
                        fontFamily: 'Livvic', fontWeight: FontWeight.w600)))),
//Text Box Container - INPUTss
        Expanded(
          flex: 25,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 10),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {});
              },
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: "Answer Prompt Here",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
//Button Container
        Expanded(
            flex: 4,
            child: Container(
                color: Colors.black,
                alignment: Alignment.center,
//Row For the Post Button
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {

                          if (isUser) {
                            print("data posted");
                            //Uncomment below to post data
                            //postData();
                          } else {

                            // User is not logged in
                            // Show a dialog and offer to take the user back to the login screen
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: const Text('Not Logged In'),
                                      content: const Text(
                                          'You cannot post unless you are logged in.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Go to Login'),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              SmoothPageTransition(child: LoginPage(),
                                            ));
                                          },
                                        )
                                      ]);
                                });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                        ),
                        child: const Text("Post",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Livvic',
                                fontWeight: FontWeight.w600)),
                      ),
                    ]))),
      ],
    );
  }
}

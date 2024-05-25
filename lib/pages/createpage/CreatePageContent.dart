// ignore_for_file: unused_local_variable
import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/pages/createpage/create_page_loadingbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuckler/pages/loginpage/login_page.dart';
import 'package:chuckler/PageTransitioner.dart';
import '../../Session.dart';
import 'package:provider/provider.dart';
import '../../database/models.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
import 'prompt_identifier.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreatePageContent extends StatefulWidget {
  const CreatePageContent({super.key});

  @override
  _CreatePageContentState createState() => _CreatePageContentState();
}

class _CreatePageContentState extends State<CreatePageContent>
    with WidgetsBindingObserver {
  final TextEditingController _controller =
      TextEditingController(text: "Answer the Prompt Here");

//state variables
  bool isUser = false;
  String userId = "";
  String userName = "";
  String promptId = "";
  String promtDateId = "";
  String timeRemaining = "";
  List<bool> canPost = List.empty(growable: true);
  List<String> textControllerStates = List.empty(growable: true);
  var promptVal = 0;
  FocusNode focusNode = FocusNode();
  bool keyBoardOut = false;

  /*
  This Function sends the post to the data base with the current text
   */
  Future<void> postData() async {
    //check if user can post
    if (canPost[promptVal]) {
      //check if user has already posted
      FirebaseFirestore firebase =
          Provider.of<FirebaseFirestore>(context, listen: false);
      final docRef = await firebase
          .collection('Posts')
          .where('uid', isEqualTo: userId)
          .where('promptId', isEqualTo: promptId)
          .where('promptDateId', isEqualTo: promtDateId)
          .limit(1)
          .get();
      if (docRef.docs.isEmpty) {
        canPost[promptVal] = false;
        try {
          createPost(firebase, _controller.text, userId, userName, promptId,
              promtDateId
          );
          incrementNumPosts(firebase, userId);
        }
        catch(error){
          print("Error: $error");
        }
        return;

      } else {
        canPost[promptVal] = false;
      }
    }
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
    focusNode.addListener(() {
      if(!focusNode.hasFocus){
        if (_controller.text.trim().isEmpty) {
          _controller.text = "Answer the Prompt Here";
        }
      }
      setState(() {
      });
    });
    checkTheUser();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
    //Set variables
    UserService userSession = Provider.of<UserService>(context, listen: false);
    userName = userSession.userId!;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    List<DbPrompt> prompts = userSession.prompts!;
    promptId = prompts[promptVal].promptId!;
    promtDateId = prompts[promptVal].promptDateId!;
    for (int i = 0; i < prompts.length; i++) {
      canPost.add(true);
      textControllerStates.add("Answer the Prompt Here");
    }

    return Column(
      children: [
        //Prompt Area
        Expanded(
            flex: 50,
            child: Container(
              constraints: BoxConstraints.tight(
                  Size(screenWidth / 1.1, double.infinity)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber, width: 5)),
              child: Column(children: [
                Expanded(flex: 1, child: Container()),
                const Expanded(flex: 6, child: PromptIdentifier()),
                Expanded(
                    flex: 20,
                    child: Center(
                        child: AutoSizeText.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.normal),
                        children: <TextSpan>[
                          TextSpan(text: prompts[promptVal].before),
                          TextSpan(
                              text: _controller.text,
                              style: const TextStyle(color: Color(0xFFffd230))),
                          TextSpan(text: prompts[promptVal].after),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      minFontSize: 2,
                    ))),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Expanded(
                    flex: 6,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  textControllerStates[promptVal] =
                                      _controller.text;
                                  if ((promptVal - 1) >= 0) {
                                    setState(() {
                                      promptVal = promptVal - 1;
                                      _controller.text =
                                          textControllerStates[promptVal];
                                    });
                                  }
                                },
                                splashRadius: 10,
                                icon: const Icon(
                                  Icons.chevron_left_outlined,
                                  color: Colors.amber,
                                ),
                              )),
                          const Expanded(
                              flex: 10, child: CreatePageLoadingBar()),
                          //PROMPT W/ USER ANSWER
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  textControllerStates[promptVal] =
                                      _controller.text;
                                  if ((promptVal + 1) < prompts.length) {
                                    setState(() {
                                      promptVal++;
                                      _controller.text =
                                          textControllerStates[promptVal];
                                    });
                                  }
                                },
                                splashRadius: 10,
                                icon: const Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.amber,
                                ),
                              )),
                        ])),
                Expanded(flex: 1, child: Container())
              ]),
            )),
        !focusNode.hasFocus
            ? Expanded(
                flex: 12,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChangingButton(
                          index: 0,
                          icons: [
                            Icons.thumb_up_off_alt,
                            Icons.thumb_up
                          ],
                          pressed: () {
                            return 1;
                          }),
                      IconButton(onPressed: (){}, icon: Icon(Icons.info, color: Colors.grey,)),
                      ChangingButton(
                          index: 0,
                          icons: [
                            Icons.thumb_down_off_alt,
                            Icons.thumb_down
                          ],
                          pressed: () {
                            return 1;
                          })
                    ],
                  ),
                ),
              )
            : Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 25,
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                    constraints: BoxConstraints.tight(
                        Size(double.infinity, screenHeight / 3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Expanded(flex: 2, child: Container()),
//Text Box Container - INPUT
                      Expanded(
                        flex: 30,
                        child: Column(children: [
                          KeyboardVisibilityBuilder(
                              builder: (context, isKeyboardVisible) {
                            if (isKeyboardVisible == true) {
                              keyBoardOut = true;
                            }
                            if (!isKeyboardVisible && keyBoardOut) {
                              keyBoardOut = false;
                              focusNode.unfocus();
                            }
                            return TextField(
                              textInputAction: TextInputAction.go,
                              controller: _controller,
                              onEditingComplete: () {
                                print("This happened");
                                focusNode.unfocus();
                              },
                              onTap: () {
                                if (_controller.text.trim() ==
                                    "Answer the Prompt Here") {
                                  _controller.text = "";
                                  setState(() {});
                                }
                              },
                              onTapOutside: (pointer) {
                                focusNode.unfocus();
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                              maxLines: 4,
                              minLines: 1,
                              maxLength: 500,
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.white,
                              focusNode: focusNode,
                              style: const TextStyle(color: Colors.amber),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth / 1.5,
                                ),
                                hintText: "Answer Prompt Here",
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.amber, width: 3)),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            );
                          }),
                          Container(
                              color: Colors.black,
//Row For the Post Button
                              child: ElevatedIconButton(
                                  color: Colors.amber,
                                  iconColor: Colors.black,
                                  fractionHeight: 40,
                                  text: "Post",
                                  width: screenWidth / 3,
                                  onPressed: () {
                                    if (isUser) {
                                      //Uncomment below to post data
                                      postData();
                                    } else {
                                      // User is not logged in
                                      // Show a dialog and offer to take the user back to the login screen
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title:
                                                    const Text('Not Logged In'),
                                                content: const Text(
                                                    'You cannot post unless you are logged in.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                        'Go to Login'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          SmoothPageTransition(
                                                            child: LoginPage(),
                                                          ));
                                                    },
                                                  )
                                                ]);
                                          });
                                    }
                                  }))
                        ]),
                      )
                    ])))),
      ],
    );
  }
}

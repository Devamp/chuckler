import 'package:flutter/material.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.amber,
        body: ExploreMainPage(),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 2));
  }
}

class ExploreElement extends StatelessWidget {
  final String Answer;
  final comments = ["This is 1 comment", "This is 2 comment"];

  ExploreElement({super.key, required this.Answer});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(flex: 1, child: Container(color: Colors.black)),
      Expanded(
          flex: 10,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        Answer,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                    Positioned(
                        top: -16,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.bookmark),
                          onPressed: () {},
                        )),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(children: <Widget>[
                    // Profile Picture
                    const Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        radius: 20.0,
                      ),
                    ),
                    const Expanded(
                        flex: 5,
                        child: Text(
                          "UserNameHere",
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      flex: 10,
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.thumb_up, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.thumb_down, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat_bubble, color: Colors.white),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  Column(
                                        children: <Widget>[
                                         CommentForm(),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: comments.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(title: Text(comments[index]));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          )),
      Expanded(flex: 1, child: Container())
    ]);
  }
}

class Explorelist extends StatelessWidget {
  final List<String> textArray = [
    'Text 1 This is a long text message to test how it fits in the chat box..........................................................',
    'Text 2',
    'Text 3',
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 1',
    'Text 2',
    'Text 3',
    // Add more text here
  ];

Explorelist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: textArray.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(5.0),
              child: ExploreElement(Answer: textArray[index]));
        },
      ),
    );
  }
}

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 5, child: ExploreHeader()),
        Expanded(flex: 35, child: Explorelist())
      ],
    );
  }
}

class ExploreHeader extends StatefulWidget {
  const ExploreHeader({super.key});

  @override
  _ExploreHeaderState createState() => _ExploreHeaderState();
}

class _ExploreHeaderState extends State<ExploreHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double searchHeight = screenHeight * 0.05;
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            Expanded(
                flex: 20,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            " Chuckler",
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 200,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                            ),
                          ),
                        ),
                      )
                    ])),
            Expanded(
              flex: 10,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.contain,
                child: IconButton(
                  color: Colors.white,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    // do something when the button is pressed
                    debugPrint('Profile picture button pressed');
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final myController = TextEditingController();
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    myController.addListener(_checkInput);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _checkInput() {
    setState(() {
      _hasInput = myController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: myController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Add a comment',
        suffixIcon: _hasInput
            ? IconButton(
          splashRadius: 16,
          splashColor: Colors.black,
          icon: Icon(Icons.send),
          onPressed: () {
            // Handle the submit action here
          },
        )
            : null,
      ),
    );
  }
}


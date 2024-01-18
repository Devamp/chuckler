import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/AppHeaderMain.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.amber,
        body: TheFeed(),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 1));
  }
}

class TheFeed extends StatelessWidget {
  const TheFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Heading
        const Expanded(flex: 3, child: MainHeaderBar()),
        //Prompt Area
        Expanded(
            flex: 15,
            child: Column(
              children: <Widget>[
                Expanded(flex: 5, child: Container()),
                Expanded(
                    flex: 20,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 10,
                            child: Container(
                                constraints: const BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Center(
                                    child: Text(
                                        "This is where the prompt will go",
                                        style:
                                            TextStyle(color: Colors.white))))),
                        Expanded(flex: 1, child: Container())
                      ],
                    )),
                Expanded(flex: 5, child: Container())
              ],
            )),
        //Answer Area
        const Expanded(flex: 20, child: FeedPost()),
      ],
    );
  }
}

class FeedPost extends StatefulWidget {
  const FeedPost({super.key});

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLeftSwipe = false;
  bool isRightSwipe = false;
  double startVal = 0;
  double difVal = 0;
  bool isSwiping = false;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: -1,
        upperBound: 1,
        duration: const Duration(seconds: 10))..addStatusListener((AnimationStatus status) {
       if(status == AnimationStatus.forward && isSwiping == true) {
        // _controller.value = 0;
         print("Working?");
       }

    });

    _controller.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: (val) {
          startVal = val.globalPosition.dx;
        },
        onHorizontalDragUpdate: (val) {
          difVal = val.globalPosition.dx - startVal;
          _controller.forward();
        },
        onHorizontalDragEnd: (val) {
         //_controller.reset();
        // _controller.value = 0;
         difVal = 0;
        },
        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.translate(
                  offset: Offset(difVal, 0),
                  child: child,
                );
              },

                child: Row(children: <Widget>[
                  Expanded(flex: 1, child: Container()),
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
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.bottomCenter,
                              child: const Text(
                                'Answer Here',
                                style: TextStyle(fontSize: 24.0),
                              ),
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
                                        icon: const Icon(Icons.bookmark,
                                            color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.messenger_rounded,
                                            color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.send_rounded,
                                            color: Colors.white),
                                        onPressed: () {},
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
                ]),
              ),
            ),

          //Swipe Control Area
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
              ))
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

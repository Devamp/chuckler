import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/AppHeaderMain.dart';
import 'package:provider/provider.dart';

//Overall Feed Hierarchy
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateProvider(),
        child: const Scaffold(
          backgroundColor: Color(0xFFffd230),
          body: TheFeed(),));
  }
}

enum CardStatus { like, dislike }

class StateProvider extends ChangeNotifier {
  //Variables
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;
  Size _screenSize = Size.zero;
  int _red = 0;
  int _green = 0;
  get red => _red;
  get green => _green;

  //Getter Methods
  Size get screenSize => _screenSize;

  Offset get position => _position;

  bool get isDragging => _isDragging;

  double get angle => _angle;

  void startPosition(DragStartDetails details) {}

  //Have the card follow your drag
  void updatePosition(DragUpdateDetails details) {
    _isDragging = true;
    _position += details.delta;
    //Change the color of the buttons
    if(_position.dx > 100) {
      _green +=  (details.delta.dx).round();
    }
    else if (position.dx < -100) {
      _red +=  (-details.delta.dx).round();
    }
    else {
      if(_isDragging) {
        _red = 0;
        _green = 0;
      }
    }

    //rotate the answer sections
    final x = _position.dx;
    _angle = 2 * (x / screenSize.width);
    notifyListeners();
  }

  //When you end your drag animate the card off the page
  void endPosition(DragEndDetails details) {
    _isDragging = false;
    final status = getStatus();
    switch (status) {
      case CardStatus.like:
        like();
      case CardStatus.dislike:
        dislike();
      default:
        resetPosition();
    }


  }

//reset the card back to its original position
  void resetPosition() {
    _position = Offset.zero;
    _angle = 0;
    _red = 0;
    _green = 0;
    notifyListeners();
  }

  void setScreenSize(ss) => _screenSize = ss;

  //Gets the status of the card based on the dx
  CardStatus? getStatus() {
    final x = _position.dx;
    final delta = 100;
    if (x >= delta) {
      return CardStatus.like;
    }
    if (x <= -delta) {
      return CardStatus.dislike;
    }
  }

  //Like animation
  void like() {
    _angle = 20;
    _position += Offset(screenSize.width / 2, 0);
    _green += (255 - _green);

    notifyListeners();
    nextCard();
  }

  //Dislike animation
  void dislike() {

    _angle = -20;
    _position -= Offset(screenSize.width / 2, 0);
    _red += (255 - _red);
    notifyListeners();
    nextCard();
  }

  //wait for animation to finish before reset
  void nextCard() async {
    await Future.delayed(Duration(milliseconds: 200));
    resetPosition();
  }
}

//Non-stateful components of the feed
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

//Stateful components of the Feed
class _FeedPostState extends State<FeedPost> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<StateProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StateProvider>(context);
    final position = provider.position;
    final isDragging = provider.isDragging;
    final time = isDragging ? 0 : 200;
    final angle = provider.angle;
    final Offset center =
    Offset(provider.screenSize.width / 2, provider.screenSize.height / 2);
    final rotatedMatrix = Matrix4.identity()
      ..translate(center.dx, center.dy)
      ..rotateZ(angle)
      ..translate(-center.dx, -center.dy);
    final redv = provider.red;
    final greenv = provider.green;

    return GestureDetector(
        onPanUpdate: (details) {
          final provider = Provider.of<StateProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<StateProvider>(context, listen: false);
          provider.endPosition(details);
          print("paning");
        },
        onPanStart: (details) {
          final provider = Provider.of<StateProvider>(context, listen: false);
          provider.startPosition(details);
          print("paning");
        },
        child:
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Expanded(
            flex: 1,
            child: AnimatedContainer(
                duration: Duration(milliseconds: time),
                curve: Curves.easeInOut,
                transform: rotatedMatrix..translate(position.dx, position.dy),
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
                                        icon: const Icon(
                                            Icons.messenger_rounded,
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
                ])),
          ),
          //Swipe Control Area
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child: IconButton(
                              onPressed: () {
                                final provider = Provider.of<StateProvider>(context, listen: false);
                                provider.dislike();
                              },
                              iconSize: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height?  MediaQuery.of(context).size.height/8: MediaQuery.of(context).size.width/8,
                              icon: Icon(Icons.thumb_down,color: Color.fromRGBO(redv,0,0,1))))),
                  Expanded(
                      flex: 1,
                      child:AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child:IconButton(
                            onPressed: () {
                              final provider = Provider.of<StateProvider>(context, listen: false);
                              provider.like();
                            },
                            iconSize: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height?  MediaQuery.of(context).size.height/8: MediaQuery.of(context).size.width/8 ,
                            icon: Icon(Icons.thumb_up),color: Color.fromRGBO(0,greenv,0,1),))),
                ],
              ))
        ]));
  }
}

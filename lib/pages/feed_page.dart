import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/AppHeaderMain.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: TheFeed(),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 1));
  }
}

class TheFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Heading
        Expanded(flex: 3, child: MainHeaderBar()),
        //Prompt Area
        Expanded(flex: 15, child: Column(
          children: <Widget>[
            Expanded(flex:5, child: Container()),
            Expanded(flex:20, child: Row(children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Expanded(flex: 10, child: Container( constraints: BoxConstraints.expand(), decoration: BoxDecoration(color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: Center(child: Text("This is where the prompt will go", style: TextStyle(color: Colors.white)))
              )),
              Expanded(flex: 1, child: Container())

            ],)
            ),
            Expanded(flex:5, child:Container())
          ],
        )),
        //Answer Area
        Expanded(
            flex: 10,
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
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomCenter,
                          child:Text(
                            'Answer Here',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(children: <Widget>[
                            // Profile Picture
                            Expanded(
                              flex: 3,
                              child: CircleAvatar(
                                radius: 20.0,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text("UserNameHere", style: TextStyle(color: Colors.white),)
                            ),
                            Expanded(
                              flex: 10,
                              child: ButtonBar(
                                alignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.bookmark,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.messenger_rounded,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send_rounded,
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
        //Swipe Control Area
        Expanded(flex: 10, child: Text("Hey"))
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:chuckler/DatabaseQueries.dart';
import 'package:chuckler/Session.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../database/models.dart';
import '../../database/isarDB.dart';
import 'feedpage_modal.dart';
import 'feedpage_promptarea.dart';
import 'package:chuckler/CustomReusableWidgets/custom_text_widgets.dart';
import 'no_user_post.dart';

class MatchupTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        constraints:
        BoxConstraints.tight(Size(double.infinity, screenHeight / 2.5)),
        margin: EdgeInsets.fromLTRB(
            screenWidth / 30, 10, screenWidth / 30, 5),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 4)),
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Center(
                          child: AutoSizeText.rich(
                            TextSpan(
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontStyle: FontStyle.italic),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "this is where the prompt will go _______. "),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            minFontSize: 2,
                          ))))),
          Divider(
            color: Colors.blueGrey,
            thickness: 2,
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ProfilePhoto(
                                username: "Test",
                                img: "",
                                radius: 20,
                              )),
                          Expanded(flex: 5, child: Text("USERNAME", style: TextStyle(color: Color(0xfffbd0bf)))),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.favorite, color: Color(0xfffbd0bf),),
                                onPressed: () {},
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(flex: 6, child: Text("Answer one here"))
                          ])),
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ProfilePhoto(
                                username: "Test",
                                img: "",
                                radius: 20,
                              )),
                          Expanded(flex: 5, child: Text("USERNAME", style: TextStyle(color: Colors.cyan)), ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.favorite, color: Colors.cyan,),
                                onPressed: () {},
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(flex: 6, child: Text("Answer one here"))
                          ])),
                ],
              )),
          Divider(
            color: Colors.blueGrey,
            thickness: 2,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              constraints: BoxConstraints.tight(Size(30,30)),
                              child: ProfilePhoto(
                                username: "Test",
                                img: "",
                                radius: 15,
                              ))),
                      Expanded(
                          flex: 12,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: Center(
                                  child: AutoSizeText.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                            "This is where the description for the prompt will go "),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    minFontSize: 2,
                                  )))),
                      Expanded(
                          flex: 3,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.chat_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ))),
                    ],
                  ))),
        ]));

  }

}
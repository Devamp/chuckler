import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuckler/DatabaseQueries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
import 'package:chuckler/CustomReusableWidgets/custom_text_widgets.dart';
import 'package:chuckler/pages/feedpage/comment_form.dart';
import 'package:provider/provider.dart';

/**
 * The following is the code for the LONG tap modal
 */

class CommentModal extends StatelessWidget {
  final cfData;
  final screenHeight;
  final screenWidth;

  const CommentModal(
      {super.key,
      required this.cfData,
      required this.screenWidth,
      required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                constraints:
                    BoxConstraints.tight(Size(screenWidth, screenHeight / 2)),
                child: Container(
                    color: Colors.black,
                    constraints: BoxConstraints.tight(
                        Size(screenWidth / 1.2, screenHeight / 1.5)),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: OpenSansText(
                                text: cfData.username,
                                fractionScreenHeight: 20,
                                fw: FontWeight.w700,
                                color: Colors.white)),
                        Expanded(
                            flex: 2,
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: screenWidth / 1.5,
                                  maxWidth: screenWidth / 1.5),
                              child: AutoSizeText.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: cfData.answer,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 10,
                                minFontSize: 2,
                              ),
                            )),
                        Expanded(
                          flex: 2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    //TODO add like function
                                    child: ChangingButton(index: 0, icons: [Icons.thumb_up_off_alt, Icons.thumb_up_off_alt_rounded],pressed: (){
                                      FirebaseFirestore firestore = Provider.of<FirebaseFirestore>(context, listen: false);
                                      //likeAPost(firestore, usernameLiker, postId, postOwnerUid)
                                      return 1;})),
                                Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: ChangingButton(index: 0, icons: [
                                      Icons.person_add_alt_rounded,
                                      Icons.person,
                                      Icons.check_circle
                                    ],
                                      //TODO add following function
                                      pressed: (){ return 2;},
                                    ))
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                minWidth: screenWidth / 1.5,
                                maxWidth: screenWidth / 1.5),
                            decoration: const BoxDecoration(
                                border: Border(
                                    // top: BorderSide(color: Colors.amber, width: 2),
                                    bottom: BorderSide(
                                        color: Colors.amber, width: 4))),
                            child: const Text(
                              "Comments",
                              style: TextStyle(color: Colors.amber),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 6,
                            child: CommentForm(
                              cfData: cfData,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                              constraints: BoxConstraints.tight(
                                  Size(screenWidth / 1.5, screenHeight / 30)),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.amber),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.black),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ))),
            Container(
              constraints:
                  BoxConstraints.tight(Size(screenWidth, screenHeight / 4)),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:chuckler/Session.dart';

import '../../database/models.dart';

class FeedPagePromptArea extends StatelessWidget {
  const FeedPagePromptArea({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context, listen: true);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    late DbPrompt thePrompt;
    for(DbPrompt p in userSession.prompts!){
      if(p.promptId == userSession.currentFeedPromptId){
        thePrompt = p;
      }
    }
    return InkWell(
      onTap: (){
        userSession.clearViewingColor();
        userSession.clearviewingPost();
      },
        child: Column(
      children: [
        Expanded(
            flex: 8,
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 30, 0, MediaQuery.of(context).size.width/ 30, MediaQuery.of(context).size.width / 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber, width: 5)
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 8,
                          child: Center(
                            child: AutoSizeText.rich(
                              TextSpan(
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: thePrompt.before,
                                      style:
                                      const TextStyle(color: Colors.white)),
                                  TextSpan(
                                      text: userSession.viewingPost,
                                      style:
                                      TextStyle(color: userSession.viewingColor)),
                                  TextSpan(
                                      text: thePrompt.after,
                                      style:
                                      const TextStyle(color: Colors.white)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 10,
                              minFontSize: 2,
                            ),
                          )),
                    ]))),

      ],
    ));
  }

}
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:chuckler/Session.dart';

class FeedPagePromptArea extends StatelessWidget {
  const FeedPagePromptArea({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userSession = Provider.of<UserService>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 30, 0, MediaQuery.of(context).size.width/ 30, MediaQuery.of(context).size.width / 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF383838),
                  borderRadius: BorderRadius.circular(20),
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
                                      text: userSession.prompts![0].before,
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
       Text("Choose the best answer", style: TextStyle(color: Colors.white, fontFamily: 'Livvic', fontWeight: FontWeight.w600, fontSize: 20),),
        Container(height: 5, width: screenWidth/1.2, margin: EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF383838) ),)
      ],
    );
  }

}
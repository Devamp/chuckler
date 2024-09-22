import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/CustomReusableWidgets/custom_text_widgets.dart';

class PromptIdentifier extends StatelessWidget {
   const PromptIdentifier({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: () {
          showCupertinoModalPopup(
              useRootNavigator: false,
              context: context,
              barrierColor: Colors.black.withOpacity(0.8),
              builder: (_) {
                return Center(
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.tight(Size(screenWidth/1.5,double.infinity)),
                        child:  Text(
                          textAlign: TextAlign.center,
                  ///TODO this needs to be dynamic
                  "HERE IS WHAT A DAILY IS!",
                  style: Theme.of(context).textTheme.displayMedium,
                )));
              });
        },
        child: Container(
          constraints:
              BoxConstraints.tight(Size(screenWidth / 1.8, double.infinity)),
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                     shape: BoxShape.circle),
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth / 30, 0),
                child: Icon(
                  Icons.access_time_sharp,
                  size: screenHeight / 35,
                  color: Colors.blueGrey,
                ),
              ),
              OpenSansText(
                ///TODO This also needs to be dynamic
                  text: "THE DAILY",
                  fractionScreenHeight: 35,
                  color: Colors.blueGrey,
                  fw: FontWeight.w700)
            ],
          ),
        ));
  }
}

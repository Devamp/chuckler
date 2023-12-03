import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainHeaderBar extends StatelessWidget {
  const MainHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: AutoSizeText(
                " Chuckler",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 100,
                  color: Colors.amber,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            )
          ],
        ));
  }
}

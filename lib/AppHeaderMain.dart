import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainHeaderBar extends StatelessWidget {
  const MainHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            const Expanded(
              flex: 4,
              child: AutoSizeText(
                " Chuckler",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 200,
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
              child: FittedBox(
                fit: BoxFit.contain,
                child: IconButton(
                  color: Colors.white,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.person, color: Colors.blue,),
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

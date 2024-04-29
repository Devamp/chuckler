import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainHeaderBar extends StatelessWidget {
  const MainHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            const Expanded(flex: 6, child: Logo()),
            Expanded(
              flex: 8,
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
                  icon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
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

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.fromLTRB(screenWidth/40, 0, 0, 0),
        child: Text(
      "CHUCKLER",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Livvic",
          fontSize: screenHeight / 35),
    ));
  }
}

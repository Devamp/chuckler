import 'package:flutter/material.dart';

class OpenSansText extends StatelessWidget {
  final String text;
  final int fractionScreenHeight;
  final Color color;
  final FontWeight fw;
  const OpenSansText({super.key, required this.text, required this.fractionScreenHeight, required this.color, required this.fw});

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(
          fontSize:  MediaQuery.of(context).size.height / fractionScreenHeight,
          fontFamily: "OpenSans",
          fontWeight: fw,
          color: color),
    );
  }
}
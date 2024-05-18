import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  final Color iconColor;
  final Color color;
  final int fractionHeight;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? text;
  final double? width;

  const ElevatedIconButton(
      {super.key, required this.color, required this.iconColor, required this.fractionHeight, this.icon, this.onPressed, this.text, this.width});
  @override
  Widget build(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        maximumSize: WidgetStateProperty.all<Size>(Size((width != null ? width! : double.infinity), double.infinity)),
        backgroundColor:
        WidgetStateProperty.all<Color>(
            color),
        foregroundColor:
        WidgetStateProperty.all<Color>(
            iconColor),
        shape: WidgetStateProperty.all<
            RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12.0),
          ),
        ),
      ),
      child:Row( mainAxisAlignment: MainAxisAlignment.center, children: [ icon != null ? Icon(
        icon,
        size: screenHeight / fractionHeight,
      ) : Container(),
        Container(child: text != null ? Text(text!, style: TextStyle(color: iconColor, fontSize: screenHeight/(fractionHeight)),) : const Text("")), // A
        ]
      )
    );
  }
}
import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  final Color iconColor;
  final Color color;
  final fractionHeight;
  final IconData icon;
  final VoidCallback? onPressed;

  const ElevatedIconButton(
      {super.key, required this.color, required this.iconColor, required this.fractionHeight, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
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
      child: Icon(
        icon,
        size: MediaQuery
            .of(context)
            .size
            .height /fractionHeight,
      ),
    );
  }
}
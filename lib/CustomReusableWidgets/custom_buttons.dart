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


class ChangingButton extends StatefulWidget {
int index;
List<IconData> icons;
List<Color> bgColors;
List<Color> iconColors;

final int Function() pressed;

ChangingButton({super.key, required this.index, required this.icons, required this.bgColors, required this.iconColors, required this.pressed});

  @override
  _ChangingButtonState createState() => _ChangingButtonState();
}

class _ChangingButtonState extends  State<ChangingButton> {
  bool disable = false;



  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
        onPressed: (){
          if(!disable) {
            setState(() {
              widget.index = widget.pressed();
              disable = true;
            });
          }
        },
        style: ButtonStyle(
        backgroundColor:WidgetStateProperty.all<Color>(widget.bgColors[widget.index]),
        foregroundColor:WidgetStateProperty.all<Color>(widget.iconColors[widget.index]),
        shape: WidgetStateProperty.all<
            RoundedRectangleBorder>(
        RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(12.0)))),
      child: Icon(widget.icons[widget.index], size: screenHeight/25, )
    );
  }
  }
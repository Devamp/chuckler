import 'package:flutter/material.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';
class CreateMiddle extends StatefulWidget {

  CreateMiddle({super.key});

  @override
  _CreateMiddleState createState() => _CreateMiddleState();
}

class _CreateMiddleState extends  State<CreateMiddle> {
int liked = 0;


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChangingButton(
            index: 0,
            icons: [
              Icons.thumb_up_alt_rounded,
              Icons.thumb_up_alt_rounded
            ],
            bgColors: [Colors.transparent, Colors.amber],
            iconColors: [Colors.amber, Colors.green],
            pressed: () {
              if(liked == 0){
                liked = 1;
              return 1;}else {return 0;}
            }),
        IconButton(onPressed: (){}, icon: Icon(Icons.info, color: Colors.grey,)),
        ChangingButton(
            index: 0,
            icons: [
              Icons.thumb_down_alt_rounded,
              Icons.thumb_down_alt_rounded
            ],
            bgColors: [Colors.transparent, Colors.amber],
            iconColors: [Colors.amber, Colors.red],
            pressed: () {
              if(liked == 0){
                liked = -1;
              return 1;}else {return 0;}
            })
      ],
    );
  }
}
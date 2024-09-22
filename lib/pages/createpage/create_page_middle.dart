import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/CustomReusableWidgets/custom_buttons.dart';

class CreateMiddle extends StatefulWidget {
  CreateMiddle({super.key});

  @override
  _CreateMiddleState createState() => _CreateMiddleState();
}

class _CreateMiddleState extends State<CreateMiddle> {
  int liked = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChangingButton(
            index: 0,
            icons: [Icons.thumb_up_alt_rounded, Icons.thumb_up_alt_rounded],
            bgColors: [Colors.black54, Colors.white],
            iconColors: [Colors.white24, Colors.black],
            pressed: () {
              if (liked == 0) {
                liked = 1;
                return 1;
              } else {
                return 0;
              }
            }),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext) {
                    //TODO MAKE THIS DIALOG NICER
                    return Dialog(
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: FittedBox(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                    constraints: BoxConstraints(
                                        maxWidth: screenWidth / 1.2,
                                        maxHeight: screenHeight / 4),
                                    child: const Text(
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        "Like or Dislike to let our creators know how they are doing!  :)")))));
                  });
            },
            icon: Icon(
              Icons.info,
              color: Colors.grey,
            )),
        ChangingButton(
            index: 0,
            icons: [Icons.thumb_down_alt_rounded, Icons.thumb_down_alt_rounded],
            bgColors: [Colors.black54, Colors.white],
            iconColors: [Colors.white24, Colors.black],
            pressed: () {
              if (liked == 0) {
                liked = -1;
                return 1;
              } else {
                return 0;
              }
            })
      ],
    );
  }
}

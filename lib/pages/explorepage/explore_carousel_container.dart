import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth / 2,
      height: screenHeight / 1.5,
      decoration: BoxDecoration(
        color: const Color(0xFF383838),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
            child: Text(
              'Category',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  letterSpacing: 0,
                  fontSize: screenHeight / 40),
            ),
          ),
          Container(
            width: screenWidth / 3,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
                color: Colors.white12, borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Text(
                '#100',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight / 20),
              ),
              Text(
                'of 100',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.normal,
                    fontSize: screenHeight / 50),
              )
            ]),
          ),
          Container(
              height: screenHeight / 4,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column( children: [Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('#' + (index+1).toString(), style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.normal),),
                          Container(margin: EdgeInsets.all(5),child: ProfilePhoto(username: "Caden", img: "", radius: 20)),

                        ]),
                      Divider(color: Colors.white, thickness: 0.2,)
                    ]);
                  }))
        ],
      ),
    );
  }
}

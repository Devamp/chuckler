import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final String position;
  final String username;
  final Color color;

  const CircleWidget(
      {super.key, required this.position, required this.color, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 125,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 8,
          )),
      child: ProfilePhoto(username: username, img: "", radius: 60),
    );
  }
}

class CarouselContainer extends StatelessWidget {
  const CarouselContainer(
      {super.key,
      required this.categoryName,
      required this.names,
      required this.points});

  final List names;
  final String categoryName;
  final List points;

  List _getStyles(int index) {
    switch (index) {
      case 0:
        return [FontWeight.bold, Colors.yellow, 19.0];
      case 1:
        return [FontWeight.bold, Colors.grey[400], 19.0];
      case 2:
        return [FontWeight.bold, Colors.brown[600], 19.0];
      default:
        return [FontWeight.bold, Colors.black, 18.0];
    }
  }

  String _getRanking(int index) {
    if (index > 2) {
      return "${index + 1}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: screenHeight - 160,
          width: screenWidth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 225,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      left: 35,
                      child: CircleWidget(
                        position: '2nd',
                        color: Colors.grey,
                        username: names[1],
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 35,
                      child: CircleWidget(
                        position: '3rd',
                        color: Colors.brown,
                        username: names[2],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 50,
                      left: 50,
                      child: CircleWidget(
                        position: '1st',
                        color: Colors.amberAccent,
                        username: names[0],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      itemCount: names.length - 3,
                      itemBuilder: (context, index) {
                        int adjustedIndex = index + 3;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(
                              left: 20, right: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.amberAccent),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(_getRanking(adjustedIndex),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight:
                                                _getStyles(adjustedIndex)[0],
                                            color: _getStyles(adjustedIndex)[1],
                                            fontSize:
                                                _getStyles(adjustedIndex)[2],
                                          )),
                                  Container(
                                      margin: const EdgeInsets.all(12),
                                      child: ProfilePhoto(
                                          username: names[adjustedIndex],
                                          img: "",
                                          radius: 20)),
                                  Text(names[adjustedIndex],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight:
                                                _getStyles(adjustedIndex)[0],
                                            color: _getStyles(adjustedIndex)[1],
                                            fontSize:
                                                _getStyles(adjustedIndex)[2],
                                          )),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text('9999',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight:
                                                  _getStyles(adjustedIndex)[0],
                                              color:
                                                  _getStyles(adjustedIndex)[1],
                                              fontSize:
                                                  _getStyles(adjustedIndex)[2],
                                            )),
                                  ),
                                ]),
                          ]),
                        );
                      })),
            ],
          ),
        ),
      ],
    );
  }
}

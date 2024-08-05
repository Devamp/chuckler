import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'leaderboard_carousel_container.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final unfocusNode = FocusNode();

  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: CarouselSlider(
                  items: const [
                    CarouselContainer(
                      categoryName: "TODAY'S LEADERS",
                      names: [
                        "Caden Deutscher",
                        "Devam Patel",
                        "Anand Gogoi",
                        "Alec Uyematsu",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                      ],
                      points: [
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999
                      ],
                    ),
                    CarouselContainer(categoryName: "MONTHLY LEADERS", names: [
                      "Caden Deutscher",
                      "Devam Patel",
                      "Anand Gogoi",
                      "Alec Uyematsu",
                      "Default Name",
                      "Default Name",
                      "Default Name",
                      "Default Name",
                      "Default Name",
                      "Default Name",
                    ], points: [
                      9999,
                      9999,
                      9999,
                      9999,
                      9999,
                      9999,
                      9999,
                      9999,
                      9999,
                      9999
                    ]),
                    CarouselContainer(
                      categoryName: "HALL OF FAME",
                      names: [
                        "Caden Deutscher",
                        "Devam Patel",
                        "Anand Gogoi",
                        "Alec Uyematsu",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                        "Default Name",
                      ],
                      points: [
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999,
                        9999
                      ],
                    ),
                  ],
                  carouselController: carouselController ??=
                      CarouselController(),
                  options: CarouselOptions(
                    initialPage: 0,
                    viewportFraction: 1,
                    disableCenter: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.8,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: false,
                    onPageChanged: (index, _) => carouselCurrentIndex = index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

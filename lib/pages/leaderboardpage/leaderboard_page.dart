import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'leaderboard_carousel_container.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final unfocusNode = FocusNode();

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;

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
      body: SafeArea(
        top: true,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
            colors: [
              Color.fromRGBO(9, 32, 63, 1),
              Color.fromRGBO(83, 120, 149, 1),
              Colors.black,
            ],
            center: Alignment(0,-0.5),
            radius: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: const [
                      CarouselContainer(
                        categoryName: "DAILY LEADERS",
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
                        CarouselSliderController(),
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
      ),
    );
  }
}

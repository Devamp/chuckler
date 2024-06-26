import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'explore_carousel_container.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              child: Container(
                width: 405,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: Text(
                  "Leaderboard",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 300,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: Text('Friends',
                    style: Theme.of(context).textTheme.headlineMedium,),
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                height: 10,
                child: CarouselSlider(
                  items: [
                   CarouselContainer(),
                    CarouselContainer(),
                    CarouselContainer(),
                  ],
                  carouselController: carouselController ??=
                      CarouselController(),
                  options: CarouselOptions(
                    initialPage: 1,
                    viewportFraction: 0.5,
                    disableCenter: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.25,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: false,
                    onPageChanged: (index, _) => carouselCurrentIndex = index,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: Text('Achievements',
                    style: Theme.of(context).textTheme.headlineMedium,),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  constraints: BoxConstraints.tight(
                      Size(screenWidth / 1.5, double.infinity)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: Colors.amber),
                  child: InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: SvgPicture.asset(
                              'assets/svgfiles/trophy-solid.svg',
                              fit: BoxFit.contain,
                              height:
                                  screenHeight / 10, // Set the desired height
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.1),
                            child: Text('?',
                                style: Theme.of(context).textTheme.bodyMedium,),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

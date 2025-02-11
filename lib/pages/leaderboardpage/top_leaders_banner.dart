import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../CustomReusableWidgets/CircleWidget.dart';
import '../publicpage/public_page.dart';

String getCategoryInfo(String category) {
  switch (category) {
    case 'Daily':
      return 'The Daily leaderboard ranks the leaders with the most liked post within 24hrs.';
    case 'Most Posts':
      return 'Most Posts leaderboard ranks the leaders who have the most total number of posts.';
    case 'Longest Streak':
      return 'Longest Streak leaderboard ranks the leaders with the longest consecutive login streak.';
    case 'Hall of Fame':
      return 'Hall of Fame leaders are the top performing and contributing members of our community.';
    default:
      return 'Tooltip not established.';
  }
}

class Leader {
  final String name;
  final String position;
  final Color color;

  Leader({required this.name, required this.position, required this.color});
}

class TopLeadersBanner extends StatelessWidget {
  final List<Leader> topLeaders;
  final String category;

  const TopLeadersBanner(
      {super.key, required this.topLeaders, required this.category});

  @override
  Widget build(BuildContext context) {
    if (topLeaders.isEmpty) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.error_sharp,
              size: 32,
            ),
            Text(
              'No Leaders Found!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 300, // Set a height for the Stack
        width: double.infinity, // Take the full width of the parent
        child: Stack(
          children: [
            Positioned(
                right: 10,
                top: 10,
                child: Tooltip(
                  message: getCategoryInfo(category),
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: const Duration(seconds: 10),
                  enableTapToDismiss: true,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  // Adjust padding
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // Adjust margins to control width
                  child: const Icon(
                    Icons.info_rounded,
                    size: 32,
                  ),
                )),
            Positioned(
              top: 25, // Distance from the top
              left: 0,
              right: 0,
              child: Text(
                topLeaders[0].name, // Use the first leader's name
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 60,
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicPage(username: topLeaders[2].name),
                    ),
                  )
                },
                child: CircleWidget(
                  position: topLeaders[2].position,
                  color: topLeaders[2].color,
                  username: topLeaders[2].name,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 60, // Same left position as CircleWidget for alignment
              child: SizedBox(
                width: 120, // Match the width of CircleWidget
                child: Text(
                  topLeaders[2].name, // Use the third leader's name
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 60,
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicPage(username: topLeaders[1].name),
                    ),
                  )
                },
                child: CircleWidget(
                  position: topLeaders[1].position,
                  color: topLeaders[1].color,
                  username: topLeaders[1].name,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 60, // Same right position as CircleWidget for alignment
              child: SizedBox(
                width: 120, // Match the width of CircleWidget
                child: Text(
                  topLeaders[1].name, // Use the second leader's name
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 40,
              right: 40,
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicPage(username: topLeaders[0].name),
                    ),
                  )
                },
                child: CircleWidget(
                  position: topLeaders[0].position,
                  color: topLeaders[0].color,
                  username: topLeaders[0].name,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import '../../CustomReusableWidgets/CircleWidget.dart';
import '../public-page.dart';

class Leader {
  final String name;
  final String position;
  final Color color;

  Leader({required this.name, required this.position, required this.color});
}

class TopLeadersBanner extends StatelessWidget {
  final List<Leader> topLeaders;

  const TopLeadersBanner({
    super.key,
    required this.topLeaders,
  });

  @override
  Widget build(BuildContext context) {
    if (topLeaders.length < 3) {
      return const SizedBox
          .shrink(); // Return empty widget if not enough leaders
    }

    return SizedBox(
      height: 300, // Set a height for the Stack
      width: double.infinity, // Take the full width of the parent
      child: Stack(
        children: [
          Positioned(
            top: 25, // Distance from the top
            left: 0,
            right: 0,
            child: Text(
              topLeaders[0].name, // Use the first leader's name
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

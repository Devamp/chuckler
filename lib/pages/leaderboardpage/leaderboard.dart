import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../CustomReusableWidgets/CircleWidget.dart';
import '../../CustomReusableWidgets/profile_photo.dart';
import '../public-page.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String selectedCategory = 'Daily'; // Track the selected category

  // Update the selected category without navigating to a new page
  void selectCategory(String category) {
    setState(() {
      selectedCategory = category; // Update the selected category
    });
  }

  Widget categoryMenu(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildCategoryButton('Daily'),
          const SizedBox(width: 10),
          buildCategoryButton('Weekly'),
          const SizedBox(width: 10),
          buildCategoryButton('Monthly'),
          const SizedBox(width: 10),
          buildCategoryButton('Hall of Fame'),
        ],
      ),
    );
  }

  ElevatedButton buildCategoryButton(String category) {
    return ElevatedButton(
      onPressed: () => selectCategory(category), // Handle button press
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedCategory == category
            ? Colors.amberAccent
            : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(
        category,
        style: TextStyle(
            fontSize: 15,
            fontWeight: selectedCategory == category
                ? FontWeight.bold
                : FontWeight.normal),
      ),
    );
  }

  // Content to display based on the selected category
  Widget buildCategoryContent() {
    switch (selectedCategory) {
      case 'Daily':
        return buildDailyLeaderboard();
      case 'Weekly':
        return buildWeeklyLeaderboard();
      case 'Monthly':
        return buildMonthlyLeaderboard();
      case 'Hall of Fame':
        return buildHallOfFameLeaderboard();
      default:
        return const SizedBox();
    }
  }

  Widget buildDailyLeaderboard() {
    // Random data for names and positions
    List<String> names = [
      'Devam Patel',
      'Caden Deutscher',
      'John Appleseed',
      'Amy Smith',
      'Kyle Winters',
      'Zarah Missing',
      'Randy',
      'CoolKid99',
      'Harrison Kingston',
      'Zoe Alvarez'
    ];
    List<String> positions = [
      '1st',
      '2nd',
      '3rd',
      '4th',
      '5th',
      '6th',
      '7th',
      '8th',
      '9th',
      '10th'
    ];

    // Random number generator for random selection
    Random random = Random();

    // Generate a list of 10 random leaders
    List<Leader> leaders = List<Leader>.generate(10, (i) {
      return Leader(
        name: names[random.nextInt(names.length)], // Randomly pick a name
        position: positions[i], // Set position based on index
        color: Colors.primaries[random.nextInt(
            Colors.primaries.length)], // Random color from predefined colors
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopLeadersBanner(
          topLeaders: [
            Leader(
                name: 'Devam Patel',
                position: '1st',
                color: Colors.amberAccent),
            Leader(
                name: 'Caden Deutscher', position: '2nd', color: Colors.grey),
            Leader(
                name: 'John Appleseed', position: '3rd', color: Colors.brown),
          ],
        ),
        buildList(leaders)
      ],
    );
  }

  Widget buildWeeklyLeaderboard() {
    // Random data for names and positions
    List<String> names = [
      'Devam Patel',
      'Caden Deutscher',
      'John Appleseed',
      'Amy Smith',
      'Kyle Winters',
      'Zarah Missing',
      'Randy',
      'CoolKid99',
      'Harrison Kingston',
      'Zoe Alvarez'
    ];
    List<String> positions = [
      '1st',
      '2nd',
      '3rd',
      '4th',
      '5th',
      '6th',
      '7th',
      '8th',
      '9th',
      '10th'
    ];

    // Random number generator for random selection
    Random random = Random();

    // Generate a list of 10 random leaders
    List<Leader> leaders = List<Leader>.generate(10, (i) {
      return Leader(
        name: names[random.nextInt(names.length)], // Randomly pick a name
        position: positions[i], // Set position based on index
        color: Colors.primaries[random.nextInt(
            Colors.primaries.length)], // Random color from predefined colors
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopLeadersBanner(
          topLeaders: [
            new Leader(
                name: 'Kyle Winters',
                position: '1st',
                color: Colors.amberAccent),
            new Leader(name: 'Amy Smith', position: '2nd', color: Colors.grey),
            new Leader(
                name: 'Zarah Missing', position: '3rd', color: Colors.brown)
          ],
        ),
        buildList(leaders)
      ],
    );
  }

  Widget buildMonthlyLeaderboard() {
    // Random data for names and positions
    List<String> names = [
      'Devam Patel',
      'Caden Deutscher',
      'John Appleseed',
      'Amy Smith',
      'Kyle Winters',
      'Zarah Missing',
      'Randy',
      'CoolKid99',
      'Harrison Kingston',
      'Zoe Alvarez'
    ];
    List<String> positions = [
      '1st',
      '2nd',
      '3rd',
      '4th',
      '5th',
      '6th',
      '7th',
      '8th',
      '9th',
      '10th'
    ];

    // Random number generator for random selection
    Random random = Random();

    // Generate a list of 10 random leaders
    List<Leader> leaders = List<Leader>.generate(10, (i) {
      return Leader(
        name: names[random.nextInt(names.length)], // Randomly pick a name
        position: positions[i], // Set position based on index
        color: Colors.primaries[random.nextInt(
            Colors.primaries.length)], // Random color from predefined colors
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopLeadersBanner(
          topLeaders: [
            new Leader(
                name: 'Harrison Kingston',
                position: '1st',
                color: Colors.amberAccent),
            new Leader(name: 'Randy', position: '2nd', color: Colors.grey),
            new Leader(name: 'CoolKid99', position: '3rd', color: Colors.brown)
          ],
        ),
        buildList(leaders)
      ],
    );
  }

  Widget buildHallOfFameLeaderboard() {
    // Random data for names and positions
    List<String> names = [
      'Devam Patel',
      'Caden Deutscher',
      'John Appleseed',
      'Amy Smith',
      'Kyle Winters',
      'Zarah Missing',
      'Randy',
      'CoolKid99',
      'Harrison Kingston',
      'Zoe Alvarez'
    ];
    List<String> positions = [
      '1st',
      '2nd',
      '3rd',
      '4th',
      '5th',
      '6th',
      '7th',
      '8th',
      '9th',
      '10th'
    ];

    // Random number generator for random selection
    Random random = Random();

    // Generate a list of 10 random leaders
    List<Leader> leaders = List<Leader>.generate(10, (i) {
      return Leader(
        name: names[random.nextInt(names.length)], // Randomly pick a name
        position: positions[i], // Set position based on index
        color: Colors.primaries[random.nextInt(
            Colors.primaries.length)], // Random color from predefined colors
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopLeadersBanner(
          topLeaders: [
            new Leader(
                name: 'Violet', position: '1st', color: Colors.amberAccent),
            new Leader(name: 'Joker', position: '2nd', color: Colors.grey),
            new Leader(name: 'Xin Fei', position: '3rd', color: Colors.brown)
          ],
        ),
        buildList(leaders)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            categoryMenu(context),
            buildCategoryContent(),
          ],
        ),
      ),
    );
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

  TopLeadersBanner({
    super.key,
    required this.topLeaders,
  });

  @override
  Widget build(BuildContext context) {
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
            child: CircleWidget(
                position: topLeaders[2].position,
                color: topLeaders[2].color,
                username: topLeaders[2].name),
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
            child: CircleWidget(
                position: topLeaders[1].position,
                color: topLeaders[1].color,
                username: topLeaders[1].name),
          ),
          Positioned(
            bottom: 15,
            right: 60, // Same left position as CircleWidget for alignment
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
            child: CircleWidget(
                position: topLeaders[0].position,
                color: topLeaders[0].color,
                username: topLeaders[0].name),
          ),
        ],
      ),
    );
  }
}

Flexible buildList(List<Leader> entries) {
  return Flexible(
    fit: FlexFit.loose,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: entries.length - 3,
          itemBuilder: (BuildContext context, int index) {
            int rank = index + 4;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicPage(username: entries[index].name),
                    ),
                  )
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[500]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      ProfilePhoto(
                        username: entries[index].name,
                        img: '',
                        radius: 22.0,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          entries[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      const SizedBox(width: 100),
                      Text(
                        rank.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

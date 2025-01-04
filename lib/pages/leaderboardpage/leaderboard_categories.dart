import 'dart:math';
import 'package:flutter/material.dart';
import '../../CustomReusableWidgets/profile_photo.dart';
import '../public-page.dart';
import 'topLeadersBanner.dart';

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
    children: [
      TopLeadersBanner(
        topLeaders: [
          Leader(
              name: 'Devam Patel', position: '1st', color: Colors.amberAccent),
          Leader(name: 'Caden Deutscher', position: '2nd', color: Colors.grey),
          Leader(name: 'John Appleseed', position: '3rd', color: Colors.brown),
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
              name: 'Kyle Winters', position: '1st', color: Colors.amberAccent),
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

Widget buildList(List<Leader> entries) {
  return SizedBox(
    height: 300,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                    color: Colors.black54),
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
  );
}

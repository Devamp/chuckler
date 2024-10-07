import 'package:chuckler/CustomReusableWidgets/CircleWidget.dart';
import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaderboardPage createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage> {
  final List<Widget> _leaderboardPages = [
    const LeadersContainer(categoryTitle: 'Longest Streak'),
    const LeadersContainer(categoryTitle: 'Most Wins'),
    const LeadersContainer(categoryTitle: 'Fastest Times'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(9, 32, 63, 1),
              Color.fromRGBO(83, 120, 149, 1),
              Colors.black,
            ],
            center: Alignment(0.6, 0.5),
            radius: 2,
          ),
        ),
        child: Column(
          children: [
            const Expanded(flex: 4, child: LeadersContainer(categoryTitle: '',)),
            const Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 175,
                      child: Text(
                        'Username',
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        'Rank',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  int rank = index + 4;
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          child: ProfilePhoto(
                            username: 'Devam',
                            img: '',
                            radius: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 170,
                          child: Text(
                            'DevamIsCool',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            rank.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeadersContainer extends StatefulWidget {
  final String categoryTitle;

  const LeadersContainer({super.key, required this.categoryTitle});

  @override
  // ignore: library_private_types_in_public_api
  _LeadersContainer createState() => _LeadersContainer();
}

class _LeadersContainer extends State<LeadersContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0))),
      child: const Stack(
        children: [
          Positioned(
              top: 20,
              left: 100,
              child: Text(
                'Longest Streak',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          Positioned(
            bottom: 40,
            left: 40,
            child: CircleWidget(
                position: '3rd', color: Colors.brown, username: 'Devam Patel'),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: CircleWidget(
                position: '2nd',
                color: Colors.grey,
                username: 'Caden Deutscher'),
          ),
          Positioned(
            top: 70,
            left: 40,
            right: 40,
            child: CircleWidget(
                position: '1st', color: Colors.amber, username: 'John Wick'),
          )
        ],
      ),
    );
  }
}

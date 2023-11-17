import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';

class AppNavBar extends StatelessWidget {

  const AppNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (itemIndex) {
        if (itemIndex == 0) {
          Navigator.pushNamed(context, '/create');
        }
        else if (itemIndex == 1) {
          Navigator.pushNamed(context, '/feed');
        }
        else if (itemIndex == 2) {
          Navigator.pushNamed(context, '/explore');
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(label: "Create", icon: Icon(Icons.create)),
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Explore", icon: Icon(Icons.explore))
      ]
    );
  }
}

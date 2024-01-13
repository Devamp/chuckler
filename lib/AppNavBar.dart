import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/PageTransitioner.dart';
import 'package:chuckler/pages/create_page.dart';
import 'package:chuckler/pages/feed_page.dart';
import 'package:chuckler/pages/explore_page.dart';
import 'package:chuckler/pages/account_page.dart';


class NavigationBarController extends StatefulWidget {
  final int initialPageIndex;

  const NavigationBarController({Key? key, required this.initialPageIndex}) : super(key: key);

  @override
  AppNavBar createState() => AppNavBar(initialPageIndex : initialPageIndex);
}

class AppNavBar extends State<NavigationBarController>{

  //Starting state
  int _currentPageIndex;

  AppNavBar({required int initialPageIndex}) : _currentPageIndex = initialPageIndex;

//Track state
void setCurrentPageIndex(int index) {
  setState(() {
   _currentPageIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        //set current selection
        currentIndex: _currentPageIndex,
        //Move to the correct tab
        onTap: (itemIndex) {
          setCurrentPageIndex(itemIndex);
          if (_currentPageIndex == 0) {
            Navigator.push(context,
              SmoothPageTransition(child: CreatePage()),
            );
          }
          else if (_currentPageIndex == 1) {
            Navigator.push(
              context,
              SmoothPageTransition(child: FeedPage()),
            );
          }
          else if (_currentPageIndex == 2) {
            Navigator.push(
              context,
              SmoothPageTransition(child: ExplorePage()),
            );
          }
          else if (_currentPageIndex == 3) {
            Navigator.push(
              context,
              SmoothPageTransition(child: AccountPage()),
            );
          }
        },
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white,
        //Creates a list of each of the icons in the nav bar
      items: [
        BottomNavigationBarItem(label: "Create", icon: Icon(Icons.create)),
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Explore", icon: Icon(Icons.explore)),
        BottomNavigationBarItem(label: "Account", icon: Icon(Icons.person))
      ]
    );
  }
}

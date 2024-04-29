import 'package:flutter/material.dart';
import 'package:chuckler/pages/create_page.dart';
import 'package:chuckler/pages/feed_page.dart';
import 'package:chuckler/pages/explore_page.dart';
import 'package:chuckler/pages/account_page.dart';


class NavigationBarController extends StatefulWidget {
  final int initialPageIndex;

  const NavigationBarController({Key? key, required this.initialPageIndex})
      : super(key: key);

  @override
  AppNavBar createState() => AppNavBar(initialPageIndex: initialPageIndex);
}

class AppNavBar extends State<NavigationBarController> {

  //Starting state
  int _currentPageIndex = 0;

  AppNavBar({required int initialPageIndex})
      : _currentPageIndex = initialPageIndex;

//Track state
  void setCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    CreatePage(),
    FeedPage(),
    ExplorePage(),
    AccountPage(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            //set current selection
            currentIndex: _currentPageIndex,
            //Move to the correct tab
            onTap: (itemIndex) {
              setCurrentPageIndex(itemIndex);
            },
            selectedItemColor: Color(0xFFffd230),
            unselectedItemColor: Colors.white,
            //Creates a list of each of the icons in the nav bar
            items: const [
              BottomNavigationBarItem(
                  label: "Create", icon: Icon(Icons.create)),
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Explore", icon: Icon(Icons.explore)),
              BottomNavigationBarItem(
                  label: "Account", icon: Icon(Icons.person))
            ]
        )


    );
  }
}

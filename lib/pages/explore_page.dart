import 'package:flutter/material.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';
class ExplorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("This is the explore page."),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 2)
    );
  }
}
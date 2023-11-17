import 'package:flutter/material.dart';
import 'package:chuckler/AppNavBar.dart';
class ExplorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("This is the explore page."),
        bottomNavigationBar: const AppNavBar()
    );
  }
}
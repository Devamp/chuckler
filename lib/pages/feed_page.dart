import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';


import 'package:chuckler/route_generator.dart';
class FeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("This is the Feed page."),
        bottomNavigationBar: const AppNavBar(),
    );
  }
}
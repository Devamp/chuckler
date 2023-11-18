import 'package:chuckler/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:chuckler/globalvars.dart';

class FeedPage extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Text("This is the Feed page."),
        bottomNavigationBar: NavigationBarController(initialPageIndex: 1)
    );
  }
}

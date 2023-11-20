import 'package:flutter/material.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:chuckler/globalvars.dart';


import 'package:chuckler/route_generator.dart';
class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is the account page."),
      bottomNavigationBar: NavigationBarController(initialPageIndex: 3)
    );
  }
}
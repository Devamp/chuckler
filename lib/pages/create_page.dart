import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/AppNavBar.dart';
class CreatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is the create page"),
      bottomNavigationBar: const AppNavBar()
    );
  }
}
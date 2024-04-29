import 'package:flutter/material.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/pages/signup_page.dart';
import 'package:chuckler/pages/explore_page.dart';
import 'package:chuckler/pages/account_page.dart';
import 'package:chuckler/pages/create_page.dart';
import 'package:chuckler/pages/feed_page.dart';
import 'package:chuckler/AppNavBar.dart';
import'package:chuckler/main.dart';

/*
This file will contain the page change logic
 */
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/app':
        return MaterialPageRoute(builder: (_) =>  const NavigationBarController(initialPageIndex: 1));
      default:
        return MaterialPageRoute(builder: (_) => MyApp());
    }
  }
}

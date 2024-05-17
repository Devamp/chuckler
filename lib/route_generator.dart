import 'package:flutter/material.dart';
import 'package:chuckler/pages/loginpage/login_page.dart';
import 'package:chuckler/pages/loginpage/signup_page.dart';
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

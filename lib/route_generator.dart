import 'package:flutter/material.dart';
import 'package:chuckler/main.dart';
import 'package:chuckler/pages/login_page.dart';
import 'package:chuckler/pages/signup_page.dart';
import 'package:chuckler/pages/explore_page.dart';
import 'package:chuckler/pages/account_page.dart';
import 'package:chuckler/pages/create_page.dart';
import 'package:chuckler/pages/feed_page.dart';

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
      case '/feed':
        return MaterialPageRoute(builder: (_) => FeedPage());
      case '/explore':
        return MaterialPageRoute(builder: (_) => ExplorePage());
      case '/account':
        return MaterialPageRoute(builder: (_) => AccountPage());
      case '/create':
        return MaterialPageRoute(builder: (_) => CreatePage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}

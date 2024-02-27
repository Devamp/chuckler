import 'package:flutter/material.dart';
import 'main.dart';
import 'package:chuckler/AppNavBar.dart';

class UserService with ChangeNotifier {
  String? _userId;
  int? _following;
  int? _followers;

  String? get userId => _userId;
  int? get following => _following;
  int? get followers => _followers;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setFollowing(int followingCount) {
    _following = followingCount;
    notifyListeners();
  }

  void setFollowers(int followersCount) {
    _followers = followersCount;
    notifyListeners();
  }

  void clearUserId() {
    _userId = null;

  }

  void clearFollowing() {
    _following = null;

  }

  void clearFollowers() {
    _followers = null;

  }

  void logout() {
    clearUserId();
    clearFollowing();
    clearFollowers();
    notifyListeners();

  }

  void reloadApp() {
    runApp(MyApp());
  }
}

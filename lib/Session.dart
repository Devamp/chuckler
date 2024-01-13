import 'package:flutter/material.dart';

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
    notifyListeners();
  }

  void clearFollowing() {
    _following = null;
    notifyListeners();
  }

  void clearFollowers() {
    _followers = null;
    notifyListeners();
  }
}

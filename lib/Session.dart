import 'package:flutter/material.dart';
import 'main.dart';
import 'package:chuckler/AppNavBar.dart';

class Post {
  String before;
  String after;
  String sponsorId;
  Post(this.before, this.after, this.sponsorId);
}
class UserService with ChangeNotifier {
  String? _userId;
  String? _postAnswer;
  int? _following;
  int? _followers;
  List<Post> _posts = List.empty(growable: true);

  String? get userId => _userId;
  int? get following => _following;
  int? get followers => _followers;
  String? get postAnswer => _postAnswer;
  List<Post>? get posts => _posts;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setPostAnswer(String postAnswer){
    _postAnswer = postAnswer;
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

  void addPost(String before, String after, String sponsorId ){
    _posts.add(Post(before, after, sponsorId));
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

  void clearPostAnswer(){
    _postAnswer = null;
  }

  void clearPosts(){
    _posts?.clear();
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

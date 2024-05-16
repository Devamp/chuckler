import 'package:flutter/material.dart';
import 'main.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database/models.dart';

class Prompt {
  String before;
  String after;
  String promptDateId;
  String promptId;
  Prompt(this.before, this.after, this.promptDateId, this.promptId);
}

class UserService with ChangeNotifier {
  String? _userId;
  bool firstLogin = false;
  String? _postAnswer;
  String? _loginTime;
  int? _following;
  int? _followers;
  List<Prompt> _prompts = List.empty(growable: true);
  List<DbPost> _currentPosts = List<DbPost>.empty(growable: true);
  String? _currentFeedPromptId;
  String? get userId => _userId;
  String? get currentFeedPromptId => _currentFeedPromptId;
  int? get following => _following;
  int? get followers => _followers;
  String? get postAnswer => _postAnswer;
  String? get logTime => _loginTime;
  List<Prompt>? get prompts => _prompts;
  List<DbPost>? get currentPosts => _currentPosts;
  //get the lastLogin as a datetime object
  DateTime getDTLogIn(){
    if(_loginTime == null){
      return DateTime(1990);
    }
    else {
      return DateTime.parse(_loginTime!);
    }

  }
  void setCurrentFeedPromptId(String s){
    _currentFeedPromptId = s;
    notifyListeners();
  }

  void setCurrentPosts(List<DbPost> posts){
    _currentPosts = posts;
    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setLoginTime(String? logint){
    _loginTime = logint;
    if(_loginTime == null){
      firstLogin = true;
    }
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

  void addPrompt(Prompt p){
    _prompts.add(p);
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

  void clearPrompts(){
    _prompts.clear();
  }






  void logout() {
    clearUserId();
    clearFollowing();
    clearFollowers();
    clearPrompts();
    notifyListeners();

  }

  void reloadApp() {
    runApp(MyApp());
  }
}

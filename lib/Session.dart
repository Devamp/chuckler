import 'package:flutter/material.dart';
import 'main.dart';
import 'package:chuckler/AppNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Prompt {
  String before;
  String after;
  String promptDateId;
  String promptId;
  Prompt(this.before, this.after, this.promptDateId, this.promptId);
}
class Post {
  String answer;
  String username;
  int postNum;
  Post(String this.answer, String this.username,int this.postNum);

}
class UserService with ChangeNotifier {
  String? _userId;
  bool firstLogin = false;
  String? _postAnswer;
  String? _loginTime;
  int? _following;
  int? _followers;
  List<Prompt> _prompts = List.empty(growable: true);
  List<Post> _posts = List.empty(growable:true);
  int? _theCurrentNumPosts;
  int? _theCurrentPostTracker;
  String? _currentFeedPromptId;
  String? get userId => _userId;
  String? get currentFeedPromptId => _currentFeedPromptId;
  int? get following => _following;
  int? get followers => _followers;
  String? get postAnswer => _postAnswer;
  String? get logTime => _loginTime;
  List<Prompt>? get prompts => _prompts;
  List<Post>? get posts => _posts;
  int? get theCurrentNumPost => _theCurrentNumPosts;
  int? get theCurrentPostTracker => _theCurrentPostTracker;
  //get the lastLogin as a datetime object
  DateTime getDTLogIn(){
    if(_loginTime == null){
      return DateTime(1990);
    }
    else {
      return DateTime.parse(_loginTime!);
    }

  }
  void setTheCurrentNumPost(int x){
    _theCurrentNumPosts = x;
    notifyListeners();
  }
  void setTheCurrentPostTracker(int x){
    _theCurrentPostTracker = x;
    notifyListeners();
  }
  void setCurrentFeedPromptId(String s){
    _currentFeedPromptId = s;
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
  void setAListOfPosts(List<Post> p){
    _posts = p;
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

  void addPost(Post p){
    _posts.add(p);
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

  void clearPosts(){
    _posts.clear();
  }





  void logout() {
    clearUserId();
    clearFollowing();
    clearFollowers();
    clearPrompts();
    clearPosts();
    notifyListeners();

  }

  void reloadApp() {
    runApp(MyApp());
  }
}

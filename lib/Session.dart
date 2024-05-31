import 'package:flutter/material.dart';
import 'main.dart';
import 'database/models.dart';


class UserService with ChangeNotifier {
  String? _userId;
  bool firstLogin = false;
  String? _postAnswer;
  String? _loginTime;
  String? _profilePhoto;
  int? _friends;
  int? _numPosts;
  int? _pendingFriends;
  String? _username;
  List<DbPrompt> _prompts = List.empty(growable: true);
  List<DbPost> _currentPosts = List<DbPost>.empty(growable: true);
  List<String> _friendsList = List<String>.empty(growable: true);
  List<String> _pendingFriendsList = List<String>.empty(growable: true);
  String? _currentFeedPromptId;
  String? get userId => _userId;
  String? get currentFeedPromptId => _currentFeedPromptId;
  int? get friends => _friends;
  int? get numPosts => _numPosts;
  String? get postAnswer => _postAnswer;
  String? get logTime => _loginTime;
  String? get username => _username;
  String? get profilePhoto => _profilePhoto;
  int? get pendingFriends => _pendingFriends;
  List<DbPrompt>? get prompts => _prompts;
  List<DbPost>? get currentPosts => _currentPosts;
  List<String>? get friendsList => _friendsList;
  List<String>? get pendingFriendsList => _pendingFriendsList;
  //get the lastLogin as a datetime object
  DateTime getDTLogIn(){
    if(_loginTime == null){ //6199885725
      return DateTime(1990);
    }
    else {
      return DateTime.parse(_loginTime!);
    }

  }
  void setFriendsList(List<String> fl){
    _friendsList = fl;
    notifyListeners();
  }
  void setPendingFriend(int pf){
    _pendingFriends = pf;
    notifyListeners();
  }
  void setUsername(String username){
    _username = username;
    notifyListeners();
  }
  void setPendingFriendsList(List<String> pfl){
    _pendingFriendsList= pfl;
    notifyListeners();
  }
  void setCurrentFeedPromptId(String s){
    _currentFeedPromptId = s;
    notifyListeners();
  }

  void setProfilePhoto(String s){
    _profilePhoto =s;
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


  void setNumPosts(int numPosts) {
    _numPosts = numPosts;
    notifyListeners();
  }

  void setFriends(int friendCount) {
    _friends = friendCount;
    notifyListeners();
  }

  void addPrompt(DbPrompt p){
    _prompts.add(p);
    notifyListeners();
  }


  void clearUserId() {
    _userId = null;

  }

  void clearFriends() {
    _friends = null;

  }

  void clearNumPosts() {
    _numPosts = null;

  }

  void clearPostAnswer(){
    _postAnswer = null;
  }

  void clearPrompts(){
    _prompts.clear();
  }






  void logout() {
    clearUserId();
    clearFriends();
    clearNumPosts();
    clearPrompts();
    notifyListeners();

  }

  void reloadApp() {
    runApp(MyApp());
  }
}

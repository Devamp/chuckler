import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'main.dart';
import 'database/models.dart';


class UserService with ChangeNotifier {
  DbUser? _loggedInUser;
  bool firstLogin = false;
  String? _postAnswer;
  String? _loginTime;
  Uint8List? promptImg;
  String _viewingPost = "____________";
  Color _viewingColor = Colors.amber;
  List<DbPost?> _userPostsForPrompts = List.empty(growable: true);
  List<DbPrompt> _prompts = List.empty(growable: true);
  List<DbPost> _currentPosts = List<DbPost>.empty(growable: true);
  String? _currentFeedPromptId;
  String? get currentFeedPromptId => _currentFeedPromptId;
  String? get postAnswer => _postAnswer;
  String? get logTime => _loginTime;
  DbUser? get loggedInUser => _loggedInUser;
  String get viewingPost => _viewingPost;
  List<DbPrompt>? get prompts => _prompts;
  List<DbPost?> get userPostsForPrompts => _userPostsForPrompts;
  List<DbPost>? get currentPosts => _currentPosts;
  Color? get viewingColor => _viewingColor;
  //get the lastLogin as a datetime object
  DateTime getDTLogIn(){
    if(_loginTime == null){ //6199885725
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
  void setViewingColor(Color c){
    _viewingColor = c;
    notifyListeners();
  }
  void setLoggedInUser(DbUser user){
    _loggedInUser = user;
    notifyListeners();
  }



  void setCurrentPosts(List<DbPost> posts){
    _currentPosts = posts;
    notifyListeners();
  }
  void setViewingPost(String viewingPost){
    _viewingPost = viewingPost;
    notifyListeners();
  }

  void setUserProfilePicture(String pic){
    loggedInUser!.profilePicture = pic;
    notifyListeners();
  }
  void setUserFriends(int friends){
    loggedInUser!.numFriends = friends;
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

void addPostForPrompt(DbPost? p){
    _userPostsForPrompts.add(p);
    notifyListeners();
}

  void addPrompt(DbPrompt p){
    _prompts.add(p);
    notifyListeners();
  }


  void clearPostAnswer(){
    _postAnswer = null;
  }

  void clearPrompts(){
    _prompts.clear();
  }


void clearviewingPost(){
    _viewingPost = "____________";
    notifyListeners();
}


void clearViewingColor(){
    _viewingColor = Colors.amber;
    notifyListeners();
}
void clearPostsForPrompts(){
    _userPostsForPrompts.clear();
    notifyListeners();
}

  void logout() {
    clearPrompts();
    clearPostsForPrompts();
    notifyListeners();

  }

  void reloadApp() {
    runApp(const MyApp());
  }
}

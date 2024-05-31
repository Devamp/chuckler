import 'package:flutter/material.dart';
import 'main.dart';
import 'database/models.dart';


class UserService with ChangeNotifier {
  DbUser? _loggedInUser;
  bool firstLogin = false;
  String? _postAnswer;
  String? _loginTime;
  List<DbPrompt> _prompts = List.empty(growable: true);
  List<DbPost> _currentPosts = List<DbPost>.empty(growable: true);
  String? _currentFeedPromptId;
  String? get currentFeedPromptId => _currentFeedPromptId;
  String? get postAnswer => _postAnswer;
  String? get logTime => _loginTime;
  DbUser? get loggedInUser => _loggedInUser;
  List<DbPrompt>? get prompts => _prompts;
  List<DbPost>? get currentPosts => _currentPosts;
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
  void setLoggedInUser(DbUser user){
    _loggedInUser = user;
    notifyListeners();
  }



  void setCurrentPosts(List<DbPost> posts){
    _currentPosts = posts;
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






  void logout() {
    clearPrompts();
    notifyListeners();

  }

  void reloadApp() {
    runApp(MyApp());
  }
}

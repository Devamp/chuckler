/*
This is the code for a mock Database using the userpreferences interface in flutter
It will not be a highlevel db but it will be enough for this app and store information
in Strings using JSON
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dbUser {
  String? username;

  dbUser(String user);

  //Turn the JSON into a User Object
  factory dbUser.fromJson(dynamic json) {
    return dbUser(json['username'] as String);
  }

  //Create the JSON
  Map toJson() {
    return {
      'username': username,
    };
  }
}

class dbPrompt extends Prompt{



  dbPrompt(super.before, super.after, super.promptDateId, super.promptId);


  //Turn the Prompt JSON into a PROMPT object
  factory dbPrompt.fromJson(dynamic json) {
    return dbPrompt(json['before'] as String, json['after'] as String,
        json['promptId'] as String, json['promptDateId'] as String);
  }

  //Create the prompt JSON
  Map toJson() {
    return {
      'before': before,
      'after': after,
      'promptId': promptId,
      'promptDateId': promptDateId
    };
  }
}

class dbPost extends Post{


  dbPost(super.answer, super.username, super.postNum);
  dbPost.fromPost(Post post) : super(post.answer, post.username,post.postNum);


//Turn Post JSON into Post Object
  factory dbPost.fromJson(dynamic json) {
    return dbPost(json['answer'] as String, json['username'] as String, json['postNum'] as int );
  }

  //Turn Post into JSON string
  Map toJson() {
    return {
      'answer': answer,
      'username': username,
      'postNum': postNum
    };
  }
}

/*
Adding a list of objects into the shared preferences
 */
Future<void> addUsers(List<dbUser> users) async {
  final prefs = await SharedPreferences.getInstance();
  String listUsers = jsonEncode(users);
  await prefs.setString('users', listUsers);
}

Future<void> addPrompts(List<dbPrompt> prompts) async {
  final prefs = await SharedPreferences.getInstance();
  String listPrompts = jsonEncode(prompts);

  await prefs.setString('prompts', listPrompts);
}

Future<void> addPosts(List<dbPost> posts) async {
  final prefs = await SharedPreferences.getInstance();
  String listPosts = jsonEncode(posts);
  await prefs.setInt('numOfPosts', posts.length);
  await prefs.setInt('onPost', 0);
  await prefs.setString('posts', listPosts);
}

//Locally caches the last time the user logged in as a string
Future<void> cacheLoginTime() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now().toUtc();
  final loginTimeString = now.toIso8601String(); // Convert to string
  await prefs.setString('lastLoginTime', loginTimeString);
}



/*
Retrieve the string from shared preferences and turn it into a list of objects
 */
Future<List<dbUser>> getUsers(List<dbUser> users) async {
  final prefs = await SharedPreferences.getInstance();
  String? ofUsers = prefs.getString('users');
  if (ofUsers == null) {
    return List<dbUser>.empty();
  }
  var jsonList = jsonDecode(ofUsers) as List;
  List<dbUser> objList =
      jsonList.map((theJson) => dbUser.fromJson(theJson)).toList();
  return objList;
}

Future<List<dbPrompt>> getPrompts() async {
  final prefs = await SharedPreferences.getInstance();
  String? ofPrompts = prefs.getString('prompts');
  if (ofPrompts == null) {
    return List<dbPrompt>.empty();
  }
  var jsonList = jsonDecode(ofPrompts) as List;
  List<dbPrompt> objList =
      jsonList.map((theJson) => dbPrompt.fromJson(theJson)).toList();
  return objList;
}

Future<List<dbPost>> getPosts(List<dbPost> posts) async {
  final prefs = await SharedPreferences.getInstance();
  String? ofPosts = prefs.getString('posts');
  if (ofPosts == null) {
    return List<dbPost>.empty();
  }
  var jsonList = jsonDecode(ofPosts) as List;
  List<dbPost> objList =
      jsonList.map((theJson) => dbPost.fromJson(theJson)).toList();
  return objList;
}

//Retrieves the last login time if it exists
Future<String?> getCachedLoginTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastLoginTime');
}

/*add a single value: works by extracting the JSON then decoding it, adding to the list then reencoding it*/
Future<void> addOneUser(dbUser user) async {
  //get instance
  final prefs = await SharedPreferences.getInstance();
  //get JSON
  String? ofUsers = prefs.getString('users');
  List<dbUser> users = List<dbUser>.empty(growable: true);
  //if JSON is empty add a user to it and be done
  if (ofUsers == null) {
    users.add(user);
  }
  //if not Empty extract the existing list and add the user to it
  else {
    var jsonList = jsonDecode(ofUsers) as List;
    users = jsonList.map((theJson) => dbUser.fromJson(theJson)).toList();
    users.add(user);
  }
  //reencode the list as JSON
  String listUsers = jsonEncode(users);
  //add to persistent storage
  await prefs.setString('users', listUsers);
}
/*Check if last login was a different day*/
Future<bool> firstLoginToday() async{
  String? strTime = await getCachedLoginTime();
  if(strTime == null){
    return true;
  }
  DateTime dt = DateTime.parse(strTime);
  DateTime now = DateTime.now().toUtc();

  if((dt.year == now.year) && (dt.month == now.month) && (dt.day == now.day)){
    return true;
  }else{
    return false;
  }
}




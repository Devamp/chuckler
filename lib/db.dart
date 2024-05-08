/*
This is the code for a mock Database using the userpreferences interface in flutter
It will not be a highlevel db but it will be enough for this app and store information
in Strings using JSON
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class User{

  String? username;

  User(String user);

  //Turn the JSON into a User Object
  factory User.fromJson(dynamic json) {
    return User(json['username'] as String);
  }

  //Create the JSON
  Map toJson(){
    return {
      'username' : username,
    };
  }

}

class Prompt{
  String? prompt;

  Prompt(String prompt);

  //Turn the Prompt JSON into a PROMPT object
  factory Prompt.fromJson(dynamic json) {
    return Prompt(json['prompt'] as String);
  }

  //Create the prompt JSON
  Map toJson(){
    return {
      'prompt' : prompt,
    };
  }
}

class Post{

  String? post;

  Post(String post);

//Turn Post JSON into Post Object
  factory Post.fromJson(dynamic json) {
    return Post(json['post'] as String);
  }

  //Turn Post into JSON string
  Map toJson(){
    return {
      'post' : post,
    };
  }
}


/*
Adding a list of objects into the shared preferences
 */
Future<void> addUsers(List<User> users) async {
  final prefs = await SharedPreferences.getInstance();
  String listUsers = jsonEncode(users);
  await prefs.setString('users', listUsers);
}
Future<void> addPrompts(List<Prompt> prompts) async {
  final prefs = await SharedPreferences.getInstance();
  String listPrompts = jsonEncode(prompts);
  await prefs.setString('prompts', listPrompts);
}
Future<void> addPosts(List<Post> posts) async {
  final prefs = await SharedPreferences.getInstance();
  String listPosts = jsonEncode(posts);
  await prefs.setString('posts', listPosts);
}

/*
Retrieve the string from shared preferences and turn it into a list of objects
 */
Future<List<User>> getUsers(List<User> users) async {
  final prefs = await SharedPreferences.getInstance();
  String? ofUsers = prefs.getString('users');
  if(ofUsers == null){
    return List<User>.empty();
  }
  var jsonList = jsonDecode(ofUsers) as List;
  List<User> objList = jsonList.map((theJson) => User.fromJson(theJson)).toList();
 return objList;
}

Future<List<Prompt>> getPrompts(List<Prompt> prompts) async {
  final prefs = await SharedPreferences.getInstance();
  String? ofPrompts = prefs.getString('prompts');
  if(ofPrompts == null){
    return List<Prompt>.empty();
  }
  var jsonList = jsonDecode(ofPrompts) as List;
  List<Prompt> objList = jsonList.map((theJson) => Prompt.fromJson(theJson)).toList();
  return objList;
}

Future<List<Post>> GetPosts(List<Post> posts) async {
  final prefs = await SharedPreferences.getInstance();
  String? ofPosts= prefs.getString('posts');
  if(ofPosts == null){
    return List<Post>.empty();
  }
  var jsonList = jsonDecode(ofPosts) as List;
  List<Post> objList = jsonList.map((theJson) => Post.fromJson(theJson)).toList();
  return objList;
}
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




/*
Adding a list of objects into the shared preferences
 */
Future<void> addUsers(List<dbUser> users) async {
  final prefs = await SharedPreferences.getInstance();
  String listUsers = jsonEncode(users);
  await prefs.setString('users', listUsers);
}


//Locally caches the last time the user logged in as a string
Future<void> cacheLoginTime() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now().toUtc();
  final loginTimeString = now.toIso8601String(); // Convert to string
  await prefs.setString('lastLoginTime', loginTimeString);
}
/**
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
*/



//Retrieve numPosts
Future<int?> getNumPosts() async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.getInt('numOfPosts');
}

//Retrieve the Post we have not seen yet
Future<int?> getCurrentPost() async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.getInt('onPost');
}

//Retrieves the last login time if it exists
Future<String?> getCachedLoginTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastLoginTime');
}
/**
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
}*/

/*Check if last login was a different day*/
Future<bool> firstLoginToday() async {
  String? strTime = await getCachedLoginTime();
  if (strTime == null) {
    return true;
  }
  DateTime dt = DateTime.parse(strTime);
  DateTime now = DateTime.now().toUtc();

  if ((dt.year == now.year) && (dt.month == now.month) && (dt.day == now.day)) {
    return true;
  } else {
    return false;
  }
}

/*
Increment the last post the user has seen
 */
Future<void> incrementLastPost() async {
  final prefs = await SharedPreferences.getInstance();
  int? val = prefs.getInt('onPost');
  val = val! + 2;
  await prefs.setInt('onPost', val);
}

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db.dart';

import 'dart:math';

/**
    @author - Caden Deutscher
    @params - firestore - firestore instance to query data from
    @return - List of prompts for today
 */
Future<List<dbPrompt>> getDailyPrompts(FirebaseFirestore firestore) async {
  List<dbPrompt> posts = List.empty(growable: true);
  DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 8));
  DateTime today = DateTime(now.year, now.month, now.day);
  // Create timestamps for the start and end dates
  Timestamp startDate = Timestamp.fromDate(today);
  Timestamp endDate =
      Timestamp.fromDate(DateTime(now.year, now.month, now.day + 1));
  QuerySnapshot querySnapshot = await firestore
      .collection('PromptDays')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThan: endDate)
      .get();
  String pid = querySnapshot.docs.first.id;
  print("this is the pid" + pid);

  if (querySnapshot.docs.isEmpty) {
    print("NO DOCS FOUND FOR TODAY $startDate");
  } else {
    CollectionReference cr =
        querySnapshot.docs.first.reference.collection("Prompts");
    final gs = await cr.get();
    if (gs.docs.isNotEmpty) {
      for (QueryDocumentSnapshot ds in gs.docs) {
        dynamic before = ds.get(FieldPath(['before']));
        dynamic after = ds.get(FieldPath(['after']));

        posts.add(dbPrompt(before, after, pid, ds.id));
      }
    }
  }
  return posts;
}

/**
 * Description: Get the 10 posts from the database...put them in the
 */
Future<List<Post>> getPosts(
    FirebaseFirestore firestore, String prmtId, String prmtDateId) async {
  final prefs = await SharedPreferences.getInstance();
  String? loginTime = prefs.getString('lastLoginTime');
  DateTime lastDate;
  if (loginTime == null) {
    lastDate = DateTime(1990);
  } else {
    lastDate = DateTime.parse(loginTime);
  }

    //Query
    QuerySnapshot querySnapshot = await firestore
        .collection('Posts')
        .where('promptId', isEqualTo: prmtId)
        .where('promptDateId', isEqualTo: prmtDateId)
        .where('date', isGreaterThan: lastDate)
        .limit(10).get();
    if(querySnapshot.docs.isEmpty){
      var rng = Random();
      var random1 = rng.nextInt(pow(2, 32).toInt());
      var random2 = rng.nextInt(pow(2, 32).toInt());
      var bigRandom = (random1 << 32) | random2;
      querySnapshot = await firestore
          .collection('Posts')
          .where('promptId', isEqualTo: prmtId)
          .where('promptDateId', isEqualTo: prmtDateId)
          .where('random', isGreaterThan: bigRandom)
          .limit(10).get();
      if(querySnapshot.docs.isEmpty) {
        querySnapshot = await firestore
            .collection('Posts')
            .where('promptId', isEqualTo: prmtId)
            .where('promptDateId', isEqualTo: prmtDateId)
            .where('random', isLessThanOrEqualTo: bigRandom)
            .limit(10).get();
      }
    }

    //create the postList
  List<Post> toReturn  = List<Post>.empty(growable: true);
  if(querySnapshot.docs.isEmpty) {
    return toReturn;
  }
  else{
    int i = 0;
    for(QueryDocumentSnapshot  doc in querySnapshot.docs){
      dynamic answer = doc.get(FieldPath(['answer']));
      dynamic username = doc.get(FieldPath(['username']));
      int postNum = i;
      toReturn.add(Post(answer,username,postNum));
      i++;

    }
    return toReturn;

  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Session.dart';

/**
  @author - Caden Deutscher
  @params - firestore - firestore instance to query data from
  @return - List of prompts for today
 */
Future<List<Prompt>>  getDailyPrompts(FirebaseFirestore firestore) async {
  List<Prompt> posts = List.empty(growable: true);
  DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 8));
  DateTime today = DateTime(now.year, now.month, now.day);
  // Create timestamps for the start and end dates
  Timestamp startDate = Timestamp.fromDate(today);
  Timestamp endDate = Timestamp.fromDate(DateTime(now.year, now.month, now.day + 1));
  QuerySnapshot querySnapshot = await firestore.collection('PromptDays').where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThan: endDate).get();
  String pid = querySnapshot.docs.first.id;
  print("this is the pid" + pid);

  if(querySnapshot.docs.isEmpty){
    print("NO DOCS FOUND FOR TODAY $startDate");
  }else{
    CollectionReference cr = querySnapshot.docs.first.reference.collection("Prompts");
    final gs = await cr.get();
    if(gs.docs.isNotEmpty){
      for(QueryDocumentSnapshot ds in gs.docs ){
        dynamic sponsor = ds.get(FieldPath(['sponsor']));
        dynamic before = ds.get(FieldPath(['before']));
        dynamic after = ds.get(FieldPath(['after']));

        posts.add(Prompt(before,after,sponsor, pid, ds.id));
      }
    }
    }
  return posts;

}

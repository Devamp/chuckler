import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/**
  @author - Caden Deutscher
  @params - firestore - firestore instance to query data from
  @return - List of prompts for today
 */
Future<QuerySnapshot?>  getDailyPrompts(FirebaseFirestore firestore) async {
  DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 8));
  DateTime today = DateTime(now.year, now.month, now.day);
  // Create timestamps for the start and end dates
  Timestamp startDate = Timestamp.fromDate(today);
  Timestamp endDate = Timestamp.fromDate(DateTime(now.year, now.month, now.day + 1));
  QuerySnapshot querySnapshot = await firestore.collection('PromptDays').where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThan: endDate).get();
  if(querySnapshot.docs.isEmpty){
    print("NO DOCS FOUND FOR TODAY $startDate");
  }else{
    CollectionReference cr = querySnapshot.docs.first.reference.collection("Prompts");
    return cr.get();
  }


}

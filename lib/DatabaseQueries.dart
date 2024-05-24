import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/models.dart';

//TODO LOOK AT IMPLEMENTING A DEBOUNCER TO PREVENT READ ABUSE

///CREATE METHODS
///
///

/**
 * @author Caden Deutscher
 * @description - adds a comment to the subcollection 'Comments' in both the user and post objects
 */
Future<void> addCommentToPost(FirebaseFirestore firestore, String postId,
    String usernameCommenter, String comment) async {
  DateTime now = DateTime.now().toUtc();

  final timestamp = Timestamp.fromDate(now);
  try {
    // Reference the comments subcollection within the post document
    final pCommentsRef = firestore.collection('Comments');

    // Create a new document within the comments subcollection
    await pCommentsRef.add({
      'username': usernameCommenter,
      'comment': comment,
      'postId': postId,
      'date': timestamp
    });
  } catch (e) {
    print('Error adding comment: $e');
  }
}

///READ METHODS
///
///

/**
    @author - Caden Deutscher
    @params - firestore - firestore instance to query data from
    @return - List of prompts for today
 */
Future<List<DbPrompt>> getDailyPrompts(FirebaseFirestore firestore) async {
  List<DbPrompt> prompts = List.empty(growable: true);
  DateTime now = DateTime.now().toUtc();
  // Calculate UTC midnight
  final utcMidnight = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.microsecond));
  // Calculate UTC 11:59 (the last second of the day before midnight)
  final utc1159 = utcMidnight.add(const Duration(days: 1, seconds: -1));

  print("UTC Midnight: $utcMidnight");
  print("UTC 11:59: $utc1159");
  DateTime today = DateTime(now.year, now.month, now.day);
  // Create timestamps for the start and end dates
  Timestamp startDate = Timestamp.fromDate(utcMidnight);
  Timestamp endDate = Timestamp.fromDate(utc1159);
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
        Map<String,dynamic> data = ds.data() as Map<String,dynamic>;
        dynamic before =  data['before'];
        dynamic after = data['after'];
        dynamic type = data['type'];
        prompts.add(DbPrompt(before, after, pid, ds.id,
            utcMidnight.toIso8601String().substring(0, 10), type));
      }
    }
  }
  return prompts;
}
/**
 * Description Retrieve logged in user information*/
Future<DbUser?> getLoggedInUserInfo(FirebaseFirestore firestore, String uid) async {
  try {
    DocumentSnapshot doc = await firestore.collection("Users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    dynamic followers = data['followers'];
    dynamic following = data['following'];
    dynamic username = data['username'];
    dynamic profilePicture = data['profileImage'];
    return DbUser(username, following, followers, profilePicture);
  }catch(error){
    print("Error $error");
    return null;
  }

}

/**
 * Description: Get the 10 posts from the database...put them in the
 */
Future<List<DbPost>> getPosts(
    FirebaseFirestore firestore, String prmtId, String prmtDateId) async {
  print("specs");
  print(prmtId);
  print(prmtDateId);
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
      .where('date', isGreaterThanOrEqualTo: lastDate)
      .limit(10).get();
  if (querySnapshot.docs.isEmpty) {
    querySnapshot = await firestore
        .collection('Posts')
        .where('promptId', isEqualTo: prmtId)
        .where('promptDateId', isEqualTo: prmtDateId)
        .limit(10)
        .get();
  }

  //create the postList
  List<DbPost> toReturn = List<DbPost>.empty(growable: true);
  if (querySnapshot.docs.isEmpty) {
    print("STILL EMPTY");
    return toReturn;
  } else {
    for (QueryDocumentSnapshot doc in querySnapshot.docs){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dynamic answer = data['answer'];
     dynamic username = data['username'];
      toReturn.add(DbPost(doc.id, answer, username));
    }
    return toReturn;
  }
}

/**
 * Description: Get the first few comments from a post
 */
Future<List<DbComment>> getComments(
    FirebaseFirestore firestore, String postId) async {
  List<DbComment> comments = List<DbComment>.empty(growable: true);
  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('Comments')
        .where('postId', isEqualTo: postId)
        .limit(5)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print("STILL EMPTY");
      return comments;
    } else {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        dynamic comment = data['comment'];
        dynamic username = data['username'];
        comments.add(DbComment(username, comment));
      }
    }
  } catch (error) {}
  return comments;
}

///UPDATE METHODS
///
///

/**
    When liking a post we will create a like-relationship document, and incrament the posts number of likes
 */
Future<void> likeAPost(
    FirebaseFirestore firestore, String likerUid, String postId, String postOwnerUid) async {
  DateTime now = DateTime.now().toUtc();

  final timestamp = Timestamp.fromDate(now);
  try {
    firestore
        .collection("Notifications")
        .doc()
        .set({'type': "like", 'postId': postId, 'liker': likerUid, 'date': timestamp, 'notify': [postOwnerUid]});
    firestore
        .collection("Posts")
        .doc(postId)
        .update({'likes': FieldValue.increment(1)});
  } catch (e) {
    print('Error adding comment: $e');
  }
}

/// To keep track of wins we will simply increment that value in posts
Future<void> postWin(FirebaseFirestore firestore, String postId) async {
  try {
    await firestore
        .collection("Posts")
        .doc(postId)
        .update({'wins': FieldValue.increment(1)});
  } catch (e) {
    print('Error adding comment: $e');
  }
}

/// ADDS a following document when a user creates a follow...This can be used bidirectionally
/// inorder to minimize both the reads and writes for document
/// Returns 0 if pending, 1 if friended, and -1 if error
Future<int> friend(FirebaseFirestore firestore, String userFriendingUid,
    String userToFriendUid) async {
  //TODO finish implementing friending
  DateTime now = DateTime.now().toUtc();

  final timestamp = Timestamp.fromDate(now);
 return 0;
}

///Updates the profile photo url for a user
Future<void> updateProfilePhoto(
    FirebaseFirestore firestore, String url, String uid) async {
  await firestore.collection("Users").doc(uid).update({'profileImage': url});
}

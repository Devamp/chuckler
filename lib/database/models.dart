import 'package:isar/isar.dart';

part 'models.g.dart';

@Collection()
class DbPost {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? postId;

  String? answer;
  String? username;
  bool seen = false;
  DbPost(this.postId, this.answer, this.username);

}

@Collection()
class DbPrompt {
  Id id = Isar.autoIncrement;
  String? before;
  String? after;
  String? promptDateId;
  String? promptId;
  String? date;
  String? type;
  DbPrompt(this.before, this.after, this.promptDateId, this.promptId, this.date, this.type);
}

@Collection()
class DbUser {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String? username;
  int? numFollowers;
  int? numFollowing;
  bool follower = false;
  bool following = false;
  bool isCurrentUser = false;
  String profilePicture = "";
  DbUser(this.username,this.numFollowing,this.numFollowers, this.profilePicture);
}


@Collection()
class DbComment {
  Id id = Isar.autoIncrement;
  String? username;
  String? comment;
  DbComment(this.username, this.comment);
}
//TODO IMPLEMENT NOTIFICATIONS
/**
 * HOW will this work? When a user performs an action that involves another user...Have google cloud functions
 * send a notfication to the User that is the target of the request...This could be liking posts/friend requests...etc
 */
@Collection()
class DbNotification{
  Id id = Isar.autoIncrement;
  String? notification;
  String? by;
  String? day;
  bool seen = false;
  DbNotification(this. notification, this.by, this. day);
}
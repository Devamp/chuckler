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
  DbPrompt(this.before, this.after, this.promptDateId, this.promptId, this.date);
}

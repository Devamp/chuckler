import 'package:isar/isar.dart';

part 'DatabaseClasses.g.dart';


@collection
class User{
  Id id = Isar.autoIncrement;

  String? username;

  String? imgLink;


}


@collection
class Post{
  Id id = Isar.autoIncrement;

  String? content;

  String? pid;

  String? dbid;

  String? aid;

  String? username;
}

@collection
class Prompts{
  Id id = Isar.autoIncrement;

  String? content;

  String? pid;

  String? dbid;

  String? sponsor;

  String? sponsorId;

}

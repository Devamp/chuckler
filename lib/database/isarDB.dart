import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class IsarService {
  static late Isar db;

  static Future<void> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      db = await Isar.open(
        [DbPostSchema, DbPromptSchema], // Here we will add a schema's
        directory: dir.path,
        inspector: true,
      );
    }

    db = await Future.value(Isar.getInstance());
  }

  /// CREATE FUNCTIONS

  //Adds a list of posts to the database
  Future<void> addPostsToDB(List<DbPost> posts) async {
    await db.writeTxn(() async {
      await db.dbPosts.putAll(posts);
    });
  }

  //Adds a list of prompts to the database
  Future<void> addPromptsToDB(List<DbPrompt> prompts) async {
    await db.writeTxn(() async {
      await db.dbPrompts.putAll(prompts);
    });
  }

  //Adds one post to the database
  Future<void> addOnePostToDB(DbPost post) async {
    await db.writeTxn(() async {
      await db.dbPosts.put(post);
    });
  }

  //Adds one prompt to the database
  Future<void> addOnePromptToDB(DbPrompt prompt) async {
    await db.writeTxn(() async {
      await db.dbPrompts.put(prompt);
    });
  }

  ///READ FUNCTIONS
  //Get a list of all the posts that the user has not seen
  Future<List<DbPost>> getUnseenPosts() async {
    final posts = await db.dbPosts.filter().seenEqualTo(false).findAll();
    return posts;
  }

  Future<List<DbPrompt>> getDailyPromptsFromDB() async {
    DateTime now = DateTime.now().toUtc();
    final utcMidnight = now.subtract(Duration(hours: now.hour, minutes: now.minute, seconds: now.second, milliseconds: now.microsecond));
  final prompts = await db.dbPrompts.filter().dateEqualTo(utcMidnight.toIso8601String().substring(0,10)).findAll();
  return prompts;
}


  ///UPDATE FUNCTIONS
  //Get two unseen posts and set the values to seen
  Future<List<DbPost>> getTwoUnseenPosts() async {
    final posts =
        await db.dbPosts.filter().seenEqualTo(false).limit(2).findAll();
    for (DbPost p in posts) {
      p.seen = true;
    }
    await db.writeTxn(() async {
      await db.dbPosts.putAll(posts);
    });

    return posts;
  }

  ///DELETE FUNCTIONS

  //Deletes all posts that have been seen already
  Future<void> deleteSeenPosts() async {
    await db.dbPosts.filter().seenEqualTo(true).deleteAll();
  }
}

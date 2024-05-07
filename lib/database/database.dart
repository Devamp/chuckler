import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dbModels.dart';

class Database {
  late Isar isar;
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
     isar = await Isar.open(
      [UserSchema,PostsSchema, PromptsSchema, SponsorsSchema],
      directory: dir.path,
    );
  }
}
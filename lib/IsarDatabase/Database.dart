import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import './DatabaseClasses.dart';

class Isar_DB {
  static late Isar isar;
  static Future<void> intialize() async {

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserSchema, PostSchema, PromptsSchema],
      directory: dir.path,
    );
    //Put CRUD METHODS BELOW
}

}

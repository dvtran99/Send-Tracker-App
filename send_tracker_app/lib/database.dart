import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:send_tracker_app/models/exercise.dart';

class DataBase {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE exercises(id INTEGER PRIMARY KEY , type CHAR(32) NOT NULL , name CHAR(32) NOT NULL, volume INTEGER NOT NULL)");
        await db.execute(
            "CREATE TABLE sends(id INTEGER PRIMARY KEY, location CHAR(10) NOT NULL, color CHAR(16) NOT NULL, grade INTEGER NOT NULL, styles TEXT NOT NULL)");
      },
    );
  }

  Future<int> insertExercises(List<Exercise> exercises) async {
    int result = 0;
    final Database db = await initializeDB();

    for (var exercise in exercises) {
      result = await db.insert('exercises', exercise.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  Future<List<Exercise>> getExercises() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('exercises');
    return queryResult.map((e) => Exercise.fromMap(e)).toList();
  }
}

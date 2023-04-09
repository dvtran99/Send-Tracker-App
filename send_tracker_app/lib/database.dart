import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:send_tracker_app/models/exercise.dart';
import 'package:send_tracker_app/models/send.dart';

class DataBase {
  // Open database. Create database if it doesn't exist at specified path
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""CREATE TABLE exercises(
            id INTEGER PRIMARY KEY, 
            date CHAR(8) NOT NULL, 
            type CHAR(32) NOT NULL, 
            name CHAR(32) NOT NULL, 
            volume INTEGER NOT NULL)""");
        await db.execute("""CREATE TABLE sends(
            id INTEGER PRIMARY KEY, 
            date CHAR(8) NOT NULL , 
            location CHAR(10) NOT NULL, 
            color CHAR(16) NOT NULL, 
            grade INTEGER NOT NULL, 
            styles TEXT NOT NULL)""");
      },
    );
  }

  // Insert a list of exercises into table
  Future<int> insertExercises(List<Exercise> exercises) async {
    int result = 0;
    final Database db = await initializeDB();

    for (var exercise in exercises) {
      result = await db.insert('exercises', exercise.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // Return list of exercises from table
  Future<List<Exercise>> getExercises() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('exercises');

    return queryResult.map((e) => Exercise.fromMap(e)).toList();
  }

  // Delete exercise at specified ID
  Future<void> deleteExercise(int id) async {
    final Database db = await initializeDB();

    await db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }

  // Return total volume for each day for specified type
  Future<List<Map>> totalVolumePerDay(String type) async {
    final Database db = await initializeDB();

    List<Map> result = await db.rawQuery(
        'SELECT date, type, SUM(volume) FROM exercises WHERE type=\'$type\' GROUP BY date ORDER BY id DESC LIMIT 10');

    db.close();

    return result;
  }

  // Insert send into table
  Future<int> insertSend(Send send) async {
    final Database db = await initializeDB();

    return await db.insert('sends', send.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Return list of sends from table
  Future<List<Send>> getSends() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('sends');

    return queryResult.map((e) => Send.fromMap(e)).toList();
  }

  // Delete send at specified ID
  Future<void> deleteSend(int id) async {
    final Database db = await initializeDB();

    await db.delete('sends', where: 'id = ?', whereArgs: [id]);
  }

  // Return total sends for each day
  Future<List<Map>> totalSendsPerDay() async {
    final Database db = await initializeDB();

    List<Map> result = await db.rawQuery(
        'SELECT date, COUNT(id) FROM sends GROUP BY date ORDER BY id DESC LIMIT 10');

    await db.close();

    return result;
  }

  // Return average sends for each day
  Future<List<Map>> averageSendsPerDay() async {
    final Database db = await initializeDB();

    List<Map> result = await db.rawQuery(
        'SELECT date, AVG(grade) FROM sends GROUP BY date ORDER BY id DESC LIMIT 10');

    await db.close();

    return result;
  }

  // Return next ID of specified table
  Future<int> nextId(String table) async {
    final Database db = await initializeDB();

    int maxId = Sqflite.firstIntValue(
            await db.rawQuery('SELECT MAX(id) FROM $table')) ??
        0;

    await db.close();

    return maxId + 1;
  }
}

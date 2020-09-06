import 'dart:io' as io;

import 'package:Gymgress/models/exercisesinfo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/bodyweightinfo.dart';
import '../models/chartInfo.dart';

class DBHelper {
  static Database _database;
  static const String ID = 'id';
  static const String DATE = 'date';
  static const String WEIGHT = 'weight';
  static const String TABLE1 = 'BodyweightInfoTable';
  static const String TABLE2 = 'ExerciseInfoTable';
  static const String DB_NAME = 'DataInfo.db';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE1($ID INTEGER,$DATE DATETIME, $WEIGHT INTEGER)');
    await db.execute(
        'CREATE TABLE $TABLE2($ID INTEGER,$DATE DATETIME, $WEIGHT INTEGER)');
  }

  Future<BodyweightInfo> saveBodyweight(BodyweightInfo bodyweightInfo) async {
    var dbClient = await database;
    bodyweightInfo.id = await dbClient.insert(TABLE1, bodyweightInfo.toMap());
    return bodyweightInfo;
  }

  Future<ExerciseInfo> saveExercise(ExerciseInfo exerciseInfo) async {
    var dbClient = await database;
    await dbClient.insert(TABLE2, exerciseInfo.toMap());
    return exerciseInfo;
  }

  Future<List<BodyweightInfo>> getBodyweightInfos() async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps =
        await dbClient.query(TABLE1);
    return maps.map((e) => BodyweightInfo.fromMap(e)).toList();
  }

  Future<List<ExerciseInfo>> getExerciseInfos(int id) async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps =
        await dbClient.query(TABLE2, where: '$ID = ?', whereArgs: [id]);
    return maps.map((e) => ExerciseInfo.fromMap(e)).toList();
  }


  Future<List<ChartInfo>> getBodyweightChartInfos() async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps = await dbClient.rawQuery('''
    SELECT AVG(weight) as weight, date
    FROM $TABLE1
    GROUP BY date
      ''');
    return maps.map((e) => ChartInfo.fromMap(e)).toList();
  }

  Future<List<ChartInfo>> getExerciseChartInfos(int id) async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps = await dbClient.rawQuery('''
    SELECT AVG(weight) as weight, date
    FROM $TABLE2
    WHERE $ID = id
    GROUP BY date
      ''');
    return maps.map((e) => ChartInfo.fromMap(e)).toList();
  }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }
}

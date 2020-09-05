import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/bodyweightinfo.dart';

class DBBodyweightInfo {
  static Database _dbBodyweightInfo;
  static const String ID = 'id';
  static const String DATE = 'date';
  static const String WEIGHT = 'weight';
  static const String TABLE = 'BodyweightInfoTable';
  static const String DB_NAME = 'bodyweightInfo.db';

  Future<Database> get dbBodyweightInfo async {
    if (_dbBodyweightInfo != null) return _dbBodyweightInfo;

    _dbBodyweightInfo = await initDB();
    return _dbBodyweightInfo;
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
        'CREATE TABLE $TABLE($ID INTEGER,$DATE DATETIME, $WEIGHT INTEGER)');
  }

  Future<BodyweightInfo> save(BodyweightInfo bodyweightInfo) async {
    var dbClient = await dbBodyweightInfo;
    bodyweightInfo.id = await dbClient.insert(TABLE, bodyweightInfo.toMap());
    return bodyweightInfo;
  }

  Future<List<BodyweightInfo>> getBodyweightInfos() async {
    var dbClient = await dbBodyweightInfo;
    List<Map<String, dynamic>> maps = await dbClient.query(TABLE);
    return maps.map((e) => BodyweightInfo.fromMap(e)).toList();
  }

  

  Future close() async {
    var dbClient = await dbBodyweightInfo;
    dbClient.close();
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../util/logger.dart';

class DB with LoggerMixin {
  Future copy() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "mydatabase.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      log("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("assets", "data/mydatabase.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      log("Opening existing database");
    }
  }

  Future<Database> openDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "mydatabase.db");
    var db = await openDatabase(path, readOnly: false);
    return db;
  }

  Future<List<Map<String, Object?>>> select(String queryCode) async {
    var db = await openDB();
    try {
      var list = await db.rawQuery(queryCode);
      return list;
    } catch (e) {
      log("error $e");
    } finally {
      db.close();
    }
    return [];
  }

  Future createTeble(String code) async {
    var db = await openDB();
    try {
      await db.execute(code);
    } catch (e) {
      log("create error= $e");
    } finally {
      db.close();
    }
  }

  Future insertLikeValue(int ts, String name) async {
    var db = await openDB();
    try {
      int recordId = await db.insert('likeStock', {'ts': ts, 'name': name});
      log("inset record id  ==$recordId");
    } catch (e) {
      log("create error= $e");
    } finally {
      db.close();
    }
  }

  Future deleteLikeValue(int ts) async {
    var db = await openDB();
    try {
      var count =
          await db.delete('likeStock', where: 'ts = ?', whereArgs: [ts]);
      log("delete count ==$count");
    } catch (e) {
      log("create error= $e");
    } finally {
      db.close();
    }
  }

  Future like(int ts, String status) async {
    var db = await openDB();
    String code = "UPDATE home SET sava_status=$status WHERE ts=$ts";
    try {
      var count = await db.rawUpdate(code);
      log("update count ==$count");
    } catch (e) {
      log("create error= $e");
    } finally {
      db.close();
    }
  }
}

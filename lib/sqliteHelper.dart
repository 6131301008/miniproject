import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';
// import 'package:md_10/randomWord.dart';

class SqliteHelper {
  String dbFile = 'lexitron.sqlite';
  Database _db;


  // copy DB file to app
  void openDB() async {
    //  find DB app's path
    String dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, dbFile);
    // print(fullPath);

    // DB existed ?
    bool existed = await databaseExists(fullPath);

    if (!existed) {
      // no DB
      // copy
      // check wether the db folder exists
      try {
        Directory(dirname(fullPath)).create(recursive: true);
      } catch (_) {
        print("Cannot find folder");
      }

      // copy from assets folder
      print("Copying db....");
      ByteData data = await rootBundle.load(join("assets/db", dbFile));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(fullPath).writeAsBytes(bytes, flush: true);
      print("DB copied");
    } else {
      print("DB existed");
    }

    // open DB
    _db = await openDatabase(fullPath, readOnly: true, singleInstance: true);
  }

  void closeDB() async {
    await _db.close();
    print("DB closed");
  }

  void searchDB() async {
    const sql = 'SELECT * FROM eng2th WHERE esearch = ?2 AND ecat = ?1';
    List list = await _db.rawQuery(sql, ['N', 'abandon']);

    // Select * from THIS table
    //   var list = await _db.query('eng2th');

    // var list = await _db.query(
    //   'eng2th',
    //    columns: ['tentry, ethai'],
    //     where: '"esearch" = ? AND "ecat" = ?',
    //     whereArgs: ['abandon', 'N'],

    //     );

    if (list.length > 0) {
      print(list);
    } else {
      print("Not Found");
    }
  }

  randomWord() async {
    Random random = new Random();
    var randomNumber = random.nextInt(80000);
    const sql = 'SELECT esearch FROM eng2th WHERE id=?';
    List list = await _db.rawQuery(sql, [randomNumber]);

    const sql2 = 'SELECT ethai FROM eng2th WHERE id=?';
    List list2 = await _db.rawQuery(sql2, [randomNumber]);

    // Select * from THIS table
    //   var list = await _db.query('eng2th');

    // var list = await _db.query(
    //   'eng2th',
    //    columns: ['tentry, ethai'],
    //     where: '"esearch" = ? AND "ecat" = ?',
    //     whereArgs: ['abandon', 'N'],

    //     );

    if (list.length > 0) {
      print(list);
    } else {
      print("Not Found");
    }

    if (list2.length > 0) {
      print(list2);
    } else {
      print("Not Found");
    }
  }

  sendData(test) {
    // print(test);
    
  }
}

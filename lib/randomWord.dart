import 'package:flutter/material.dart';
// import 'package:md_10/sqliteHelper.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'package:md_10/homePage.dart';
import 'package:md_10/resultPage.dart';
import 'package:md_10/randomSyn.dart';

class Randomword extends StatefulWidget {
  @override
  _RandomwordState createState() => _RandomwordState();
}

class _RandomwordState extends State<Randomword> {
  SqliteHelper helper;
  var _th = "assets/images/thai.png";
  var _en = "assets/images/england.png";
  var count = 0;
  var _enWord = " - ";
  var _thWord = " - ";
  var _pos = " - ";
  var _currentEn = "";
  var _currentTh = "";
  var _currentPos = "";

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

  randomWord() async {
    Random random = new Random();
    var randomNumber = random.nextInt(80000);
    const sql = 'SELECT eentry FROM eng2th WHERE id=?';
    List list = await _db.rawQuery(sql, [randomNumber]);

    const sql2 = 'SELECT tentry FROM eng2th WHERE id=?';
    List list2 = await _db.rawQuery(sql2, [randomNumber]);

    const sql3 = 'SELECT ecat FROM eng2th WHERE id=?';
    List list3 = await _db.rawQuery(sql3, [randomNumber]);

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
      // _currentEn = list.toString();
      String test = list.toString();
      _currentEn = test.substring(10, test.length - 2);
      if (_currentEn == "null") {
        _currentEn = "NOT FOUND !";
      }

      String test3 = list3.toString();
      _currentPos = test3.substring(8, test3.length - 2);
    } else {
      print("Not Found");
    }

    if (list2.length > 0) {
      print(list2);
      String test2 = list2.toString();
      _currentTh = test2.substring(9, test2.length - 2);
      if (_currentTh == "null") {
        _currentTh = "NOT FOUND !";
      }

      String test4 = list3.toString();
      _currentPos = test4.substring(8, test4.length - 2);
    } else {
      print("Not Found");
    }
  }

  void search() {
    randomWord();
    setState(() {
      if (count == 0) {
        // En
        _enWord = _currentEn;
        _thWord = _currentTh;
        _pos = _currentPos;
      } else {
        _thWord = _currentEn;
        _enWord = _currentTh;
        _pos = _currentPos;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // helper = SqliteHelper();
    openDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
      ),

      endDrawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.symmetric(horizontal: 110, vertical: 50),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'PTSans',
              ),
            ),
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Search',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Resultpage()),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Random Word',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Randomword()),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Random Synonym',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Randomsyn()),
                );
              },
            ),
          ),
          // Card(
          //   color: Colors.lightBlue[100],
          //   child: ListTile(
          //     title: Text(
          //       'Random Fact',
          //       style: TextStyle(
          //         fontSize: 20,
          //         fontFamily: 'PTSans',
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          // Card(
          //   color: Colors.lightBlue[100],
          //   child: ListTile(
          //     title: Text(
          //       'Match The Words',
          //       style: TextStyle(
          //         fontSize: 20,
          //         fontFamily: 'PTSans',
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
        ],
      )),
      // Drawrrawer

      // Background picture

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/book3.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        // Background picture

        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            children: [
              // LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/dict1.png',
                    width: 100,
                  )
                ],
              ),
              // LOGO

              // Slogan
              Column(
                children: [
                  Text(
                    'My Dict',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'PTSans',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Search It Yourself',
                    style: TextStyle(
                      fontFamily: 'PTSans',
                    ),
                  ),
                ],
              ),
              // Slogan

              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // Thai flag
              //     SizedBox(
              //       width: 100, // specific value
              //       child: FlatButton(
              //         onPressed: () {},
              //         child: Image.asset(
              //           '${_th}',
              //           width: 80,
              //         ),
              //       ),
              //     ),
              //     // Thai flag

              //     // Arrow to change language
              //     SizedBox(
              //       width: 60,
              //       child: RaisedButton(
              //         onPressed: () {
              //           setState(() {
              //             if (count == 0) {
              //               _th = "assets/images/england.png";
              //               _en = "assets/images/thai.png";
              //               count = 1;
              //             } else {
              //               _th = "assets/images/thai.png";
              //               _en = "assets/images/england.png";
              //               count = 0;
              //             }
              //           });
              //         },
              //         child: Icon(Icons.arrow_forward),
              //       ),
              //     ),
              //     // Arrow to change language

              //     // England flag
              //     SizedBox(
              //       width: 100,
              //       child: FlatButton(
              //         onPressed: () {},
              //         child: Image.asset(
              //           '${_en}',
              //           width: 80,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // England flag
              SizedBox(
                height: 10,
              ),
              // Random words title
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: search,
                    child: Container(
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.grey[200],
                        child: ListTile(
                          title: Text(
                            'Random Word',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'PTSans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Random words title
              SizedBox(
                height: 20,
              ),
              // Result field
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 800,
                    height: 400,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Random Word',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'English',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '${_enWord}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Thai',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '${_thWord}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Part of speech',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                '${_pos}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Result field
            ],
          ),
        ),
      ),
    );
  }
}

class SqliteHelper {
  // String dbFile = 'lexitron.sqlite';
  // Database _db;

  // // copy DB file to app
  // void openDB() async {
  //   //  find DB app's path
  //   String dbPath = await getDatabasesPath();
  //   String fullPath = join(dbPath, dbFile);
  //   // print(fullPath);

  //   // DB existed ?
  //   bool existed = await databaseExists(fullPath);

  //   if (!existed) {
  //     // no DB
  //     // copy
  //     // check wether the db folder exists
  //     try {
  //       Directory(dirname(fullPath)).create(recursive: true);
  //     } catch (_) {
  //       print("Cannot find folder");
  //     }

  //     // copy from assets folder
  //     print("Copying db....");
  //     ByteData data = await rootBundle.load(join("assets/db", dbFile));
  //     List<int> bytes =
  //         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //     await File(fullPath).writeAsBytes(bytes, flush: true);
  //     print("DB copied");
  //   } else {
  //     print("DB existed");
  //   }

  //   // open DB
  //   _db = await openDatabase(fullPath, readOnly: true, singleInstance: true);
  // }

  // void closeDB() async {
  //   await _db.close();
  //   print("DB closed");
  // }

  // void searchDB() async {
  //   const sql = 'SELECT * FROM eng2th WHERE esearch = ?2 AND ecat = ?1';
  //   List list = await _db.rawQuery(sql, ['N', 'abandon']);

  //   // Select * from THIS table
  //   //   var list = await _db.query('eng2th');

  //   // var list = await _db.query(
  //   //   'eng2th',
  //   //    columns: ['tentry, ethai'],
  //   //     where: '"esearch" = ? AND "ecat" = ?',
  //   //     whereArgs: ['abandon', 'N'],

  //   //     );

  //   if (list.length > 0) {
  //     print(list);
  //   } else {
  //     print("Not Found");
  //   }
  // }

  // randomWord() async {
  //   Random random = new Random();
  //   var randomNumber = random.nextInt(80000);
  //   const sql = 'SELECT esearch FROM eng2th WHERE id=?';
  //   List list = await _db.rawQuery(sql, [randomNumber]);

  //   const sql2 = 'SELECT ethai FROM eng2th WHERE id=?';
  //   List list2 = await _db.rawQuery(sql2, [randomNumber]);

  //   // Select * from THIS table
  //   //   var list = await _db.query('eng2th');

  //   // var list = await _db.query(
  //   //   'eng2th',
  //   //    columns: ['tentry, ethai'],
  //   //     where: '"esearch" = ? AND "ecat" = ?',
  //   //     whereArgs: ['abandon', 'N'],

  //   //     );

  //   if (list.length > 0) {
  //     print(list);
  //   } else {
  //     print("Not Found");
  //   }

  //   if (list2.length > 0) {
  //     print(list2);
  //   } else {
  //     print("Not Found");
  //   }
  // }

  // sendData(test) {
  //   // print(test);
  // }
}

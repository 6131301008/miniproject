import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'package:md_10/homePage.dart';
import 'package:md_10/randomWord.dart';
import 'package:md_10/randomSyn.dart';

class Resultpage extends StatefulWidget {
  @override
  _ResultpageState createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  final TextEditingController inputWord = TextEditingController();
  var _th = "assets/images/thai.png";
  var _en = "assets/images/england.png";
  var count = 0;
  var _definition = " - ";
  var pos = " - ";
  var syn = " - ";
  var currentInput = " - ";

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
    if (count == 0) {
      print("English");
      const sql = 'SELECT eentry FROM eng2th WHERE tentry = ?';
      List list = await _db.rawQuery(sql, [inputWord.text]);

      const sql2 = 'SELECT ecat FROM eng2th WHERE tentry = ?';
      List list2 = await _db.rawQuery(sql2, [inputWord.text]);

      const sql3 = 'SELECT esyn FROM eng2th WHERE tentry = ?';
      List list3 = await _db.rawQuery(sql3, [inputWord.text]);

      if (list.length > 0) {
        print(list[0]);
        String test = list[0].toString();

        print(list2[0]);
        String test2 = list2[0].toString();

        print(list3[0]);
        String test3 = list3[0].toString();
        setState(() {
          _definition = test.substring(9, test.length - 1);
          pos = test2.substring(7, test2.length - 1);
          syn = test3.substring(7, test3.length - 1);
          print(syn);
          if (syn == " null") {
            syn = "NOT FOUND !";
          }
          currentInput = inputWord.text;
        });
      } else {
        setState(() {
          _definition = "Not Found";
          pos = "Not Found";
          syn = "Not Found";
          currentInput = inputWord.text;
        });
      }
    } else {
      print("Thai mode");
      const sql = 'SELECT tentry FROM eng2th WHERE eentry = ?';
      List list = await _db.rawQuery(sql, [inputWord.text]);

      const sql2 = 'SELECT ecat FROM eng2th WHERE eentry = ?';
      List list2 = await _db.rawQuery(sql2, [inputWord.text]);

      const sql3 = 'SELECT ethai FROM eng2th WHERE eentry = ?';
      List list3 = await _db.rawQuery(sql3, [inputWord.text]);

      if (list.length > 0) {
        print(list[0]);
        String test = list[0].toString();

        print(list2[0]);
        String test2 = list2[0].toString();

        print(list3[0]);
        String test3 = list3[0].toString();
        setState(() {
          _definition = test.substring(9, test.length - 1);
          pos = test2.substring(7, test2.length - 1);
          syn = test3.substring(7, test3.length - 1);
          print(syn);
          if (test3 == "null") {
            syn = "NOT FOUND !";
          }
          currentInput = inputWord.text;
        });
      } else {
        setState(() {
          _definition = "Not Found";
          pos = "Not Found";
          syn = "Not Found";
          currentInput = inputWord.text;
        });
      }
    }
  }

  void search() {
    // searchDB();
    searchDB();
    // print("okay");
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
      // Draw
      // Drawer
      // Drawer
      body: Container(
        // Background picture
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
              // logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/dict1.png',
                    width: 100,
                  )
                ],
              ),
              // logo

              // SLOGAN
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
              // SLOGAN

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Thai flag
                  SizedBox(
                    width: 100, // specific value
                    child: FlatButton(
                      onPressed: () {},
                      child: Image.asset(
                        '${_th}',
                        width: 80,
                      ),
                    ),
                  ),
                  // Thai flag

                  // Arrow to change language
                  SizedBox(
                    width: 60,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (count == 0) {
                            _th = "assets/images/england.png";
                            _en = "assets/images/thai.png";
                            count = 1;
                            inputWord.text = "";
                          } else {
                            _th = "assets/images/thai.png";
                            _en = "assets/images/england.png";
                            count = 0;
                            inputWord.text = "";
                          }
                        });
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                  // Arrow to change language

                  // England flag
                  SizedBox(
                    width: 100,
                    child: FlatButton(
                      onPressed: () {},
                      child: Image.asset(
                        '${_en}',
                        width: 80,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),
                  // Search field
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: inputWord,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Search!',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                          fontFamily: 'PTSans',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Search field
                  SizedBox(
                    width: 30,
                  ),

                  // Go button
                  RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: search,
                    padding: EdgeInsets.all(17.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      'Go',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'PTSans',
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              // Go button
              SizedBox(
                height: 20,
              ),

              // Search result
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
                          ListTile(
                            title: Text(
                              'Result: $currentInput',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Definition: ${_definition}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Part of Speech: ${pos}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Synonyms: ${syn}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Search result
            ],
          ),
        ),
      ),
    );
  }
}

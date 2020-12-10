import 'package:flutter/material.dart';
import 'package:md_10/sqliteHelper.dart';

class DictionaryDemo extends StatefulWidget {
  @override
  _DictionaryDemoState createState() => _DictionaryDemoState();
}

class _DictionaryDemoState extends State<DictionaryDemo> {
  SqliteHelper helper;

  void search() {
    helper.searchDB();
  }

  @override
  void initState() {
    super.initState();
    helper = SqliteHelper();
    helper.openDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary'),
      ),
      body: Container(
        child: RaisedButton(
          onPressed: search,
          child: Text('Select'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareDemo extends StatefulWidget {
  @override
  _ShareDemoState createState() => _ShareDemoState();
}

class _ShareDemoState extends State<ShareDemo> {
  int _counter = 0;

  void addCounter() async {
    setState(() {
      _counter++;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('kcounter', _counter);
  }

  void load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int num = pref.getInt('kcounter');
    if (num == null) {
      num = 0;
    }
    setState(() {
      _counter = num;
    });
  }

  @override
  void initState() {
    super.initState();
    // loading local storage
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: Center(
        child: Text("Count = ${_counter}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}

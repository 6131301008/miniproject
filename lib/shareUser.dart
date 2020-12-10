import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shareuser extends StatefulWidget {
  @override
  _ShareuserState createState() => _ShareuserState();
}

class _ShareuserState extends State<Shareuser> {
  bool _gender = true;
  TextEditingController tcName = TextEditingController();
  TextEditingController tcAge = TextEditingController();

  void changeGender(bool value) {
    setState(() {
      _gender = value;
    });
  }

  void showAlert(String title, String content) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        });
  }

  void save() async {
    //get textfield data
    String name = tcName.text;
    int age = int.tryParse(tcAge.text);

    if (age != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      Map<String, dynamic> data = {'name': name, 'age': age, 'gender': _gender};
      String json = jsonEncode(data);
      pref.setString('kdata', json);
      // pref.setString('kname', name);
      // pref.setInt('kage', age);
      // pref.setBool('kgender', _gender);
      showAlert('Success', 'Saved');
    } else {
      showAlert('Fail', 'Cannot save to local storage');
    }
  }

  void load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String json = pref.get('kdata');

    if (json != null) {
      Map data = jsonDecode(json);
      tcName.text = data['name'];
      tcAge.text = data['age'].toString();
      setState(() {
        _gender = data['gender'];
      });
    }
    // String name = pref.get('kname');
    // int age = pref.get('kage');
    // bool sex = pref.get('kgender');
    // if (name != null) {
    //   setState(() {
    //     tcName.text = name;
    //   });
    // }
    // if (age != null) {
    //   tcAge.text = age.toString();
    // }
    // if (sex != null) {
    //   setState(() {
    //     _gender = sex;
    //   });
    // }
  }

  void clear() async {
    tcName.text = '';
    tcAge.text = '';
    setState(() {
      _gender = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    // pref.remove('kname');
    showAlert('Success', 'Cleared');
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share user'),
      ),
      body: Column(
        children: [
          TextField(
            controller: tcName,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: tcAge,
            decoration: InputDecoration(hintText: 'Age'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Male'),
              Switch(value: _gender, onChanged: changeGender),
              Text('Female')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: save,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              OutlineButton(
                onPressed: clear,
                child: Text(
                  'Clear',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:md_10/resultPage.dart';
import 'package:md_10/randomWord.dart';
import 'package:md_10/randomSyn.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
      ),

      // Drawer
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
                height: 50,
              ),
              // National flag
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Search field and Go button
                  Spacer(),
                  RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Resultpage()),
                      );
                    },
                    padding: EdgeInsets.all(17.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      'Go to search',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'PTSans',
                      ),
                    ),
                  ),
                  Spacer(),
                  // Search field and Go button
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Randomfact extends StatefulWidget {
  @override
  _RandomfactState createState() => _RandomfactState();
}

class _RandomfactState extends State<Randomfact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
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
                fontSize: 40,
                fontFamily: 'PTSans',
              ),
            ),
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Random Word',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Random Fact',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.lightBlue[100],
            child: ListTile(
              title: Text(
                'Match The Words',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      )),
      // Drawer

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
                height: 10,
              ),

              // Random words title
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.grey,
                      child: ListTile(
                        title: Text(
                          'Random Fact',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSans',
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
                    height: 300,
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          'Random Fact',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSans',
                          ),
                        ),
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

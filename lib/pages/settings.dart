import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/authentification/login.dart';
import 'package:project_fin_etude/pages/contact.dart';
import 'package:project_fin_etude/styles/styles.dart';

final _auth = FirebaseAuth.instance;

FirebaseUser loggedInUser;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  ListTile listBuilder({Icon ico, Text txt}) {
    return ListTile(
      leading: ico,
      title: txt,
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.settings,
          color: Colors.greenAccent,
          size: 28.0,
        ),
        title: Text(
          'Settings',
          style: kPagetitle,
        ),
      ),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 22,
                  color: Colors.greenAccent,
                ),
                title: Text(loggedInUser.email),
              ),
            ),
            Card(
              child: Column(
                children: [
                  listBuilder(
                      ico: Icon(
                        Icons.help,
                        size: 22,
                        color: Colors.greenAccent,
                      ),
                      txt: Text(
                        'Help & Support',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )),
                  Divider(
                    color: Colors.black12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Contact()));
                    },
                    child: listBuilder(
                        ico: Icon(
                          Icons.message,
                          size: 22,
                          color: Colors.greenAccent,
                        ),
                        txt: Text(
                          'Contact us',
                          style: TextStyle(fontSize: 22),
                        )),
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  listBuilder(
                      ico: Icon(
                        Icons.star,
                        size: 22,
                        color: Colors.greenAccent,
                      ),
                      txt: Text(
                        'Rate us',
                        style: TextStyle(fontSize: 22),
                      )),
                  Divider(
                    color: Colors.black12,
                  ),
                  listBuilder(
                      ico: Icon(
                        Icons.feedback,
                        size: 22,
                        color: Colors.greenAccent,
                      ),
                      txt: Text(
                        'Report',
                        style: TextStyle(fontSize: 22),
                      )),
                  Divider(
                    color: Colors.black12,
                  ),
                  listBuilder(
                      ico: Icon(
                        Icons.share,
                        size: 22,
                        color: Colors.greenAccent,
                      ),
                      txt: Text(
                        'Share',
                        style: TextStyle(fontSize: 22),
                      )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _auth.signOut().whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage())));
              },
              child: Card(
                child: listBuilder(
                    ico: Icon(
                      Icons.exit_to_app,
                      size: 22,
                      color: Colors.greenAccent,
                    ),
                    txt: Text(
                      'Log out',
                      style: TextStyle(fontSize: 22),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

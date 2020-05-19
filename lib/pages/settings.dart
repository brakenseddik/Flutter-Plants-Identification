import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/contact.dart';
import 'package:project_fin_etude/styles/styles.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/authentification/login.dart';
import 'package:project_fin_etude/pages/welcome/onBoarding.dart';
import 'package:project_fin_etude/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(new Duration(seconds: 6), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 95.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('PLANTEEX', style: kHeaderTitle),
                Divider(
                  height: 20,
                ),
                Text('Explore medical plants', style: kbigTitle),
              ],
            ),
          )),
    );
  }
}

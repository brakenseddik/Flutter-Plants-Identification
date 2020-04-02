import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/home.dart';
import 'package:project_fin_etude/pages/welcome/onBoarding.dart';
class Splash extends StatefulWidget {

  @override

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4),
            () =>  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OnboardingScreen(
          ),)));
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
          child: SafeArea(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('FLOOREX',
                  style: TextStyle(
                    color: Colors.white,fontSize: 38,letterSpacing: 22,
                    fontFamily: 'Crimson Text',fontWeight: FontWeight.w700,
                  ),),
                Divider(
                  height: 20,
                ),
                Text('Explore medical plants',
                  style: TextStyle(
                      fontFamily: 'Lato',fontWeight: FontWeight.normal,

                      color: Colors.white,fontSize: 18),),

              ],
            ),
          ))
      ),
    );
  }
}


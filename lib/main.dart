import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/home.dart';
import 'package:project_fin_etude/pages/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String,WidgetBuilder>{
        '/profile':(context)=>Profile()
      },
      title: 'Planteex',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home() ,
    );
  }
}


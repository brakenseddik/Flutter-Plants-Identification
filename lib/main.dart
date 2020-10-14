import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/plant_profile.dart';
import 'package:project_fin_etude/pages/welcome/splashScreen.dart';
import 'package:project_fin_etude/provider/fav_status.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => Fav(),
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{'/profile': (context) => Profile()},
      title: 'Planteex',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.greenAccent,
        ),
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
      ),
      home: Splash(),
    );
  }
}

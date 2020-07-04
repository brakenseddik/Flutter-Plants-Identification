import 'package:flutter/material.dart';
import 'package:project_fin_etude/provider/fav_status.dart';

import 'package:project_fin_etude/pages/profile.dart';
import 'package:project_fin_etude/pages/welcome/splashScreen.dart';
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
      title: 'Plantex',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
    );
  }
}

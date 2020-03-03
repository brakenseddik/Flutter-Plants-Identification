import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
           SafeArea(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 50),
               child: FlatButton(
                 onPressed: (){},
                 child: AppBar(
                   elevation: 4.0,
                   leading: IconButton(icon: Icon(Icons.search,color: Color(0XFF787575),), onPressed: (){}),
                   actions: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(right:15.0),
                       child: IconButton(
                         onPressed: (){
                         },
                         icon: Icon(Icons.keyboard_voice,
                         color: Color(0XFF787575),
                         size: 28,
                       ),
                       ),
                     ),
                   ],
                   backgroundColor: Color(0XFFF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(35)),
          ),
               ),
             ),
           ) ,
        ],
      ),



    );
  }
}
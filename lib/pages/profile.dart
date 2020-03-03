import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';


class Profile extends StatefulWidget {
  final DocumentSnapshot post;
  Profile({this.post});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child:new ListView (
            children: <Widget>[
             Stack(children: <Widget>[
               Container(
                 height: MediaQuery.of(context).size.height / 3,
                 child: Carousel(
                   boxFit: BoxFit.fill,
                   images: [
                     NetworkImage(widget.post.data['album]'].toString())     ,
                     AssetImage('images/map_of_italy_81968107_169647531044320_7038524835093477766_n.jpg'),
                     AssetImage('images/map_of_europe_80001364_165672874708236_8451702131749635568_n.jpg'),
                   ],
                 ),
               ),
               Positioned(
                 top: 10,
                 left: 15.0,
                 child: IconButton(icon: Icon(Icons.chevron_left,color: Colors.white), onPressed: (){  Navigator.pop(context);
                 }),
               )
             ],
             ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 15),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                     Text('Historique',style: TextStyle(color: Colors.black87,fontSize: 24),),
                     Text(widget.post.data['history'],style: TextStyle(color: Colors.black38,fontSize: 18),)
                     ],
                   ),
                 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Discription',style: TextStyle(color: Colors.black87,fontSize: 24),),
                        Text(widget.post.data['description'],style: TextStyle(color: Colors.black38,fontSize: 18),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Emploi',style: TextStyle(color: Colors.black87,fontSize: 24),),
                        Text(widget.post.data['emploi'],style: TextStyle(color: Colors.black38,fontSize: 18),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Historique',style: TextStyle(color: Colors.black87,fontSize: 24),),
                        Text('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjhgghjyuughjgjhghjghjgjhgjhhghjghjghjghjghjghjghjghjghjgjgj',style: TextStyle(color: Colors.black38,fontSize: 18),)
                      ],
                    ),
                  ),

              ],
        ),
        ]
        ),
        ),
      ),
    );
  }
}

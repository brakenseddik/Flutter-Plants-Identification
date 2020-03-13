import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
                     NetworkImage(widget.post.data['album'][0]),
                     NetworkImage(widget.post.data['album'][1]),
                     NetworkImage(widget.post.data['album'][2]),
                     NetworkImage(widget.post.data['album'][3]),
                   ],
                 ),
               ),

               Positioned(
                 top: 10,
                 left: 15.0,
                 child: IconButton(icon: Icon(Icons.chevron_left,color: Colors.white), onPressed: (){  Navigator.pop(context);
                 }),
               ),
               Positioned(
                 top: 15,
                 right: 15.0,
                 child: Container(
                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25 )),
                   child: IconButton(icon: Icon(Icons.favorite_border,color: Colors.greenAccent,size:28),
                       onPressed: (){  Navigator.pop(context);
                   }),
                 ),
               ),
             ],
             ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.local_florist,color: Colors.green,size: 24,),
                        SizedBox(width: 15,),
                        Text(widget.post.data['name'],style: TextStyle(fontSize: 24),)
                      ],),
                      Row(children: <Widget>[
                        Icon(Icons.category,color: Colors.green,size: 24,),
                        SizedBox(width: 15,),
                        Text(widget.post.data['family'],style: TextStyle(fontSize: 24),)
                      ],),

                    ],
                  ),
                ),
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

              ],
        ),
        ]
        ),
        ),
      ),
    );
  }
}

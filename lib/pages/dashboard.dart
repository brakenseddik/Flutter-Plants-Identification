import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(
    Dashboard()
);
class Dashboard extends StatelessWidget {
  Future getPosts()async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection('plants').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

    home: new Scaffold(
        body: SafeArea(
            child:FutureBuilder(
                future: getPosts(),
                builder: (_,snapshot){
                  if(snapshot.connectionState==ConnectionState.none)
                  {
                    return Center(
                      child: Text('Check your internet connection...'),
                    );
                  }
                  else{
                    navigatDetail(DocumentSnapshot post){
                      Navigator.of(context,rootNavigator: true).push(CupertinoPageRoute(builder: (context) =>Profile(post: post,)));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15.0),
                            child: GestureDetector(
                              onTap: ()=>navigatDetail(snapshot.data[index]),
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.network(snapshot.data[index].data['avatar'],
                                        height: 100,
                                        width: 170,
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    SizedBox(width:15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.local_florist,color: Colors.greenAccent,),
                                            SizedBox(width: 15,),
                                            Text(snapshot.data[index].data['name'],style: TextStyle(fontSize: 18.0),),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.class_,color: Colors.greenAccent,),
                                            SizedBox(width: 15,),
                                            Text(snapshot.data[index].data['family'],style: TextStyle(fontSize: 18.0),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Icon(Icons.favorite_border,color: Colors.greenAccent,size: 30,),
                                      ],
                                    )
                                  ],
                                ) ,
                              ),
                            ),
                          );
                        },
                    );
                  }
                }
            ),

        ),
      ),
    );
  }
}
//        ListView.builder(
//          itemBuilder: (context,index){
//            return Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15.0),
//              child: GestureDetector(
//                onTap: (){
//                  Navigator.of(context,rootNavigator: true).push(CupertinoPageRoute(builder: (context) =>Profile()));
//
//                },
//                child: Card(
//                  elevation: 3.0,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(16.0)
//                  ),
//                  child: Row(
//                    children: <Widget>[
//                      ClipRRect(
//                        child: Image.asset('images/map_of_italy_81968107_169647531044320_7038524835093477766_n.jpg',
//                          height: 100,
//                          width: 170,
//                          fit: BoxFit.fill,
//                        ),
//                        borderRadius: BorderRadius.circular(20),
//                      ),
//                      SizedBox(width:15,),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Icon(Icons.local_florist,color: Colors.greenAccent,),
//                              SizedBox(width: 15,),
//                              Text('Plant Name',style: TextStyle(fontSize: 18.0),),
//                            ],
//                          ),
//                          SizedBox(
//                            height: 25,
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Icon(Icons.class_,color: Colors.greenAccent,),
//                              SizedBox(width: 15,),
//                              Text('Familly',style: TextStyle(fontSize: 18.0),),
//                            ],
//                          )
//                        ],
//                      ),
//                      Icon(Icons.favorite_border,color: Colors.greenAccent,size: 30,)
//                    ],
//                  ) ,
//                ),
//              ),
//            );
//          },
//          itemCount: 20,
//        ),
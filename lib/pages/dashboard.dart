import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_fin_etude/classes/fav_status.dart';
import 'package:project_fin_etude/pages/profile.dart';
import 'package:provider/provider.dart';

void main() => runApp(Dashboard());

class Dashboard extends StatefulWidget {
//what  do u want to do ?//
  // i want those snapshots to be availabe globally ah ok so create a new function my code is very disorgabized

  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('plants')
        .orderBy('key', descending: false)
        .getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    Fav provideFav = Provider.of<Fav>(context, listen: false);
    provideFav.populateIsFav();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          color: Colors.greenAccent,
          size: 28.0,
        ),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black54, fontSize: 24.0),
        ),
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<Fav>(builder: (context, favValues, _) {
          return Stack(
            children: <Widget>[
              FutureBuilder(
                  future: getPosts(),
                  builder: (_, snapshot) {
                    if (snapshot.error == true) {
                      return Center(
                        child: Text('Error! Check your internet connection...'),
                      );
                    } else if (snapshot.data == null) {
                      return Center(
                        child: Text('Please wait...'),
                      );
                    } else {
                      navigatDetail(DocumentSnapshot post) {
                        print(post.data);
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => Profile(
                              post: post,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                navigatDetail(snapshot.data[index]);
                              },
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: Image.network(
                                            snapshot.data[index].data['avatar'],
                                            height: 115,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.4,
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.local_florist,
                                                  color: Colors.greenAccent,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data[index].data['name'],
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.class_,
                                                  color: Colors.greenAccent,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .data['family'],
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 25,
                                      child: IconButton(
                                          onPressed: () {
                                            if (favValues.isFav[index]) {
                                              Provider.of<Fav>(context,
                                                      listen: false)
                                                  .deleteFavStatus(snapshot
                                                      .data[index].documentID);
                                            } else {
                                              Provider.of<Fav>(context,
                                                      listen: false)
                                                  .getUserandPost(snapshot
                                                      .data[index].documentID);
                                            }

                                            // print(isFav);
                                          },
                                          icon: Icon(
                                              favValues.isFav[index]
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.greenAccent,
                                              size: 28)),
                                    )
                                  ],
                                ), //
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ],
          );
        }),
      ),
    );
  }

  Widget _icon(IconData icon,
      {Color color = Colors.transparent,
      double size = 28,
      double padding = 10,
      bool isOutLine = false}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.transparent, //theme data
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        /*olor:
        isOutLine ? Colors.grey : Colors.transparent,*/
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
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

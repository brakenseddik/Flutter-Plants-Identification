import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/provider/fav_status.dart' show Fav;
import 'package:provider/provider.dart';
import 'package:project_fin_etude/styles/styles.dart';
import 'profile.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool deleting = false;
  Future<Map<String, dynamic>> getUserLikedData() async {
    final Map<String, dynamic> allLikedItems = {};
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.uid;
    final snap = await Firestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: userId)
        .getDocuments();
    final List<String> favoriteItems = [];
    snap.documents.forEach((element) {
      favoriteItems.add(element.data['item']);
    });

    for (String itemId in favoriteItems) {
      final plantData =
          await Firestore.instance.collection('plants').document(itemId).get();
      allLikedItems.addAll({itemId: plantData.data});
    }
    //print(allLikedItems);
    return allLikedItems;
  }
  /*Future<void> deleteFavoriteStatus(String plantId) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.uid;
    final ref = await Firestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: userId)
        .where('item', isEqualTo: plantId)
        .getDocuments();
    final all = ref.documents;
    for (var each in all) {
      await Firestore.instance
          .collection('favorites')
          .document(each.documentID)
          .delete();
    }
  }*/

  navigatDetail(DocumentSnapshot post) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => Profile(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.save_alt,
          color: Colors.greenAccent,
          size: 28,
        ),
        title: Text(
          'Saved',
          style: kPagetitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
            future: getUserLikedData(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final showData =
                  (snapshot.data as Map<String, dynamic>).values.toList();
              showData.forEach((element) {
                // print(element['name']);
              });
              final idList =
                  (snapshot.data as Map<String, dynamic>).keys.toList();
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: showData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 14),
                    child: GestureDetector(
                      //onTap:navigatDetail(showData[index]),
                      onTap: () async {
                        QuerySnapshot snaps = await Firestore.instance
                            .collection('plants')
                            .where('name', isEqualTo: showData[index]['name'])
                            .getDocuments();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      post: snaps.documents[0],
                                    )));
                      },
                      child: Card(
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipRRect(
                                  child: Image.network(
                                    showData[index]['avatar'],
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16)),
                                ),
                                Positioned(
                                    top: 16.0,
                                    right: 20.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          deleting = true;
                                        });
                                        Provider.of<Fav>(context, listen: false)
                                            .deleteFavStatus(idList[index])
                                            .then((value) => setState(() {
                                                  deleting = false;
                                                }));
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: deleting
                                              ? CircularProgressIndicator()
                                              : Icon(
                                                  Icons.delete,
                                                  size: 25,
                                                  color: Colors.greenAccent,
                                                )),
                                    )),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  showData[index]['name'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

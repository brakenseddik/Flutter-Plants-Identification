import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Fav extends ChangeNotifier {
  Firestore firestore=Firestore.instance;

  List<bool> isFav=[];
  List<String> documentIds=[];
  void populateIsFav()async{
    QuerySnapshot qn = await firestore.collection('plants').orderBy('key',descending: false).getDocuments();

    for(var i in qn.documents){
      isFav.add(false);
      documentIds.add(i.documentID);
    }
    correctIsFav();
  }
  void correctIsFav()async{
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.uid;
    final snap = await Firestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: userId)
        .getDocuments();
    for(var s in snap.documents){
      int index = documentIds.indexOf(s.data['item']);

      isFav[index]=true;

    }

    notifyListeners();
  }
  void rectifyIsFav(String plantId,bool recVal){
    int index = documentIds.indexOf(plantId);

    isFav[index]=recVal;
    notifyListeners();
  }

  Future<void> deleteFavStatus(String plantId) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.uid;
    final ref = await Firestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: userId)
        .where('item', isEqualTo: plantId)
        .getDocuments();
    final all = ref.documents;
    await Firestore.instance
        .collection('favorites')
        .document(all[0].documentID)
        .delete();

   rectifyIsFav(plantId,false);

  }

  Future<void> getUserandPost(String plantID) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.uid;
    final snap = await Firestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: userId)
        .where('item', isEqualTo: plantID)
        .getDocuments();
    if (snap.documents.isEmpty) {
      await Firestore.instance.collection('favorites').add({'uid': userId,'item':plantID});

     rectifyIsFav(plantID,true);

    } else {
      return;
    }
  }

}
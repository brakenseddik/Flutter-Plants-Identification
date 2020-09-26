import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class loggedUser with ChangeNotifier {
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}

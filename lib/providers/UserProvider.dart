
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  FirebaseAuth? _firebaseAuth;

  FirebaseAuth? get firebaseAuth {
    return _firebaseAuth;
  }

  void setFirebaseAuth(FirebaseAuth? instance) {
    _firebaseAuth = instance;

    notifyListeners();
  }
}
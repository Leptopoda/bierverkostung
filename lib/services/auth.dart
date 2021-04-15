// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';

import 'package:bierverkostung/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create UserData obj based on firebase user
  UserData? _userFromFirebaseUser(User? user) {
    return (user != null)
        ? UserData(
            uid: user.uid,
            guid: user.uid,
          )
        : null;
  }

  // auth change user stream
  Stream<UserData?> get user {
    return _auth.userChanges().map(_userFromFirebaseUser);
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // register in anon
  Future<UserData?> registerAnon() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      final UserData? user = _userFromFirebaseUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  /* Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  } */

  // register with email and password
  /* Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  } */

  // sign out <void>??
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

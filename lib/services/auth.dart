// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create UserData obj based on firebase user
  /* Future<UserData?> _userFromFirebaseUser(User? user) async {
    final IdTokenResult? token = await user?.getIdTokenResult();
    return (token?.claims != null) ? UserData.fromMap(token!.claims!) : null;
  } */

  // auth change user stream
  Stream<User?> get user {
    // TODO: maybe use idTokenChanges instead of user
    return _auth.userChanges();
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  Future<dynamic?> getClaim(String value) async {
    final IdTokenResult? token = await _auth.currentUser?.getIdTokenResult();
    return token?.claims?[value];
  }

  User? getUser() {
    return _auth.currentUser;
  }

  // register in anon
  Future<bool> registerAnon() async {
    try {
      await _auth.signInAnonymously();
      return true;
    } catch (error) {
      developer.log(
        'error on anonymous register',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return false;
    }
  }

  // sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      developer.log(
        'error on email sign in',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return false;
    }
  }

  // register with email and password
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (error) {
      developer.log(
        'error on email register',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return false;
    }
  }

  // sign in with Google and password
  /* Future<bool> signInWithGoogle(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      developer.log(
        'error on email sign in',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return false;
    }
  } */

  // register with Google and password
  /* Future<bool> registerWithGoogle(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      developer.log(
        'error on email register',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return false;
    }
  } */

  // refresh Token
  Future refreshToken() async {
    await _auth.currentUser?.getIdToken(true);
  }

  // sign out <void>??
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      developer.log(
        'error on sign out',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
      return null;
    }
  }
}

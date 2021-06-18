// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bierverkostung/services/firebase/database.dart';

class AuthService {
  const AuthService();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Map<String, dynamic>? claims;

  // create UserData obj based on firebase user
  static Future<User?> _userFromFirebaseUser(User? user) async {
    final IdTokenResult? token = await _auth.currentUser?.getIdTokenResult();
    claims = token?.claims;
    return user;
  }

  // auth change user stream
  static Stream<User?> get user {
    // TODO: maybe use idTokenChanges instead of user
    return _auth.userChanges().asyncMap(_userFromFirebaseUser);
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  @Deprecated('use the [AuthService.claims]')
  static Future<dynamic> getClaim(String value) async {
    final IdTokenResult? token = await _auth.currentUser?.getIdTokenResult();
    return token?.claims?[value];
  }

  static User? getUser() {
    return _auth.currentUser;
  }

  // register in anon
  static Future<bool> registerAnon() async {
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
  static Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
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
  static Future<bool> registerWithEmailAndPassword(
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

  // refresh Token
  static Future<void> refreshToken() async {
    await _auth.currentUser?.getIdToken(true);
  }

  // sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await DatabaseService.clearLocalCache();
    } catch (error) {
      developer.log(
        'error on sign out',
        name: 'leptopoda.bierverkostung.AuthService',
        error: jsonEncode(error.toString()),
      );
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

}

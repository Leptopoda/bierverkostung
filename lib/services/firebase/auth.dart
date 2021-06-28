// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bierverkostung/services/firebase/database.dart';

/// Helpers for creating and managing users on firebase auth.
class AuthService {
  const AuthService();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Map<String, dynamic>? _claims;

  /// gets the users groupID.
  /// If null it'll return the uid
  static String get groupID =>
      (_claims?['group_id'] as String?) ?? _auth.currentUser!.uid;

  /// gets the current [User] object
  static User? get getUser => _auth.currentUser;

  // create UserData obj based on firebase user
  static Future<User?> _userFromFirebaseUser(User? user) async {
    final IdTokenResult? token = await _auth.currentUser?.getIdTokenResult();
    _claims = token?.claims;
    return user;
  }

  /// Stream containing the current user
  static Stream<User?> get user {
    return _auth.idTokenChanges().asyncMap(_userFromFirebaseUser);
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  /// gets the users customClaims
  @Deprecated('use the [AuthService.claims]')
  static Future<dynamic> getClaim(String value) async {
    final IdTokenResult? token = await _auth.currentUser?.getIdTokenResult();
    return token?.claims?[value];
  }

  /// registers a new User Anonymously
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

  /// signs in a User with email and password
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

  /// registers a new User with email and password
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

  /// refreshes the users token
  /// used to load new claims
  static Future<void> refreshToken() async {
    await _auth.currentUser?.getIdToken(true);
  }

  /// signs out the user
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

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';

class DatabaseService {
  final UserData? user;
  DatabaseService({required this.user});

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserData? user2;

  // Stats
  // save Stat
  Future<void> saveStat(Stat stat) async {
    _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('stats')
        .add(stat.toMap());
  }

  // get stats stream
  Stream<List<Stat>> get stats {
    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('stats')
        .snapshots()
        .map((list) => list.docs.map((doc) => Stat.fromMap(doc)).toList());
  }

  // Tasting
  // save Tasting
  Future<void> saveTasting(Tasting tasting) async {
    _firestore
        .collection('groups')
        .doc(user!.guid)
        .collection('tastings')
        .add(tasting.toMap());
  }

  // get tasting stream
  Stream<List<Tasting>> get tastings {
    return _firestore
        .collection('groups')
        .doc(user!.guid)
        .collection('tastings')
        .snapshots()
        .map((list) => list.docs.map((doc) => Tasting.fromMap(doc)).toList());
  }

  // Beer
  // save Beer
  Future<void> saveBeer(Beer beer) async {
    _firestore
        .collection('groups')
        .doc(user!.guid)
        .collection('beers')
        .add(beer.toMap());
  }

  // get beers stream
  Stream<List<Beer>> get beers {
    return _firestore
        .collection('groups')
        .doc(user!.guid)
        .collection('beers')
        .snapshots()
        .map((list) => list.docs.map((doc) => Beer.fromMap(doc)).toList());
  }

  // User
  // save User
  /* Future<void> saveUser() async {
    await _firestore.collection('users').doc(user2!.uid).set(user2!.toMap());
  } */

  // init user
  /* Future<void> initDB(UserData _user) async {
    final result = await _firestore.collection('users').doc(_user.uid).snapshots().first;
    user2 = UserData.fromMap(result);
  } */

// get users stream
/* Stream<UserData?> get users {
    return (user2 != null)
        ? _firestore
        .collection('users')
        .doc(user2!.uid)
        .snapshots()
        .map((doc) => UserData.fromMap(doc))
        : AuthService().user;
  } */

  // Group
  // save Group
  /* Future<void> saveGroups(UserData user) async {
    _firestore
        .collection('groups')
        .doc(user.guid)
        .collection('info')
        .add(user.toMap());
  } */

  // get groups stream
  /* Stream<List<UserData>> get groups {
    return _firestore
        .collection('groups')
        .doc(user.guid)
        .collection('info')
        .snapshots()
        .map((list) => list.docs.map((doc) => UserData.fromMap(doc)).toList());
  } */
}

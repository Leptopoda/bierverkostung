// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';
// import 'package:bierverkostung/models/beer_styles.dart';
// import 'package:bierverkostung/models/breweries.dart';
// import 'package:bierverkostung/models/countries.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stats
  // save Stat
  Future<void> saveStat(Stat stat) async {
    _firestore.collection('u-$uid').add(stat.toMap());
  }

  // get stats stream
  Stream<List<Stat>> get stats {
    return _firestore
        .collection('u-$uid')
        .snapshots()
        .map((list) => list.docs.map((doc) => Stat.fromMap(doc)).toList());
  }

  // Tasting
  // save Tasting
  Future<void> saveTasting(Tasting tasting) async {
    _firestore
        .collection('groups')
        .doc(uid)
        .collection('tastings')
        .add(tasting.toMap());
  }

  // get tasting stream
  Stream<List<Tasting>> get tastings {
    return _firestore
        .collection('groups')
        .doc(uid)
        .collection('tastings')
        .snapshots()
        .map((list) => list.docs.map((doc) => Tasting.fromMap(doc)).toList());
  }

  // Beer
  // save Beer
  Future<void> saveBeer(Beer beer) async {
    _firestore
        .collection('groups')
        .doc(uid)
        .collection('beers')
        .add(beer.toMap());
  }

  // get beers stream
  Stream<List<Beer>> get beers {
    return _firestore
        .collection('groups')
        .doc(uid)
        .collection('beers')
        .snapshots()
        .map((list) => list.docs.map((doc) => Beer.fromMap(doc)).toList());
  }
}

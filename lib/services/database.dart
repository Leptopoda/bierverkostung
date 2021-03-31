// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/tastings.dart';
// import 'package:bierverkostung/models/beers.dart';
// import 'package:bierverkostung/models/beer_styles.dart';
// import 'package:bierverkostung/models/breweries.dart';
// import 'package:bierverkostung/models/countries.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveStat(Stat stat) async {
    _firestore.collection('u-$uid').add(
      {
        'date': stat.timestamp,
        'amount': stat.menge,
      },
    );
  }

  Future<void> saveTasting(Tasting tasting) async {
    _firestore.collection('groups').doc(uid).collection('tastings').add(
      {
        'beer': tasting.beer.beerName,
        'date': tasting.date,
      },
    );
  }

  // tasting list from snapshots

  // get stat stream
  Stream<List<Stat>> get stats {
    return _firestore
        .collection('u-$uid')
        .snapshots()
        .map((list) => list.docs.map((doc) => Stat.fromMap(doc)).toList());
  }

  // get user doc stream
  Stream<List<Tasting>> get tastings {
    return _firestore
        .collection('groups')
        .doc(uid)
        .collection('tastings')
        .snapshots()
        .map((list) => list.docs.map((doc) => Tasting.fromMap(doc)).toList());
  }
}

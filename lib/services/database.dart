// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/beer_styles.dart';
import 'package:bierverkostung/models/breweries.dart';
import 'package:bierverkostung/models/countries.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  // final CollectionReference userCollection = FirebaseFirestore.instance.collection('uuid');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveStat(Stat stat) async {
    firestore.collection('u-$uid').add({
      'date': stat.timestamp,
      'amount': stat.menge,
    });
  }

  Future<void> saveTasting(Tasting tasting) async {
    firestore.collection('groups').doc(uid).collection('tastings').add({
      'beer': tasting.beer.beerName,
      'date': tasting.date,
    });
  }

  // stat list from snapshot
  List<Stat> _statListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Stat(
        menge: double.parse(doc.get('amount').toString()),
        timestamp: DateTime.parse(doc.get('date').toDate().toString()),
      );
    }).toList();
  }

  // tasting list from snapshots
  List<Tasting> _tastingListFromSnapshot(QuerySnapshot snapshot) {
    final Beer bier1 = Beer(beerName: 'Paulaner');
    return snapshot.docs.map((doc) {
      return Tasting(
        date: DateTime.parse(doc.get('date').toDate().toString()),
        beer: bier1,
      );
    }).toList();
  }

  // get stat stream
  Stream<List<Stat>> get stats {
    return firestore
        .collection('u-$uid')
        .snapshots()
        .map(_statListFromSnapshot);
  }

  // get user doc stream
  Stream<List<Tasting>> get tastings {
    return firestore
        .collection('groups')
        .doc(uid)
        .collection('tastings')
        .snapshots()
        .map(_tastingListFromSnapshot);
  }
}

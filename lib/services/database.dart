// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/models/stats.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  // final CollectionReference userCollection = FirebaseFirestore.instance.collection('uuid');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveStat(Stat stat) async {
    firestore.collection(uid).add({
      'date': stat.timestamp,
      'amount': stat.menge,
    });
  }

  // brew list from snapshot
  List<Stat> _statListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Stat(
          menge: double.parse(doc.get('amount').toString()),
          timestamp: DateTime.parse(doc.get('date').toDate().toString()));
    }).toList();
  }

  // user data from snapshots
  /* UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  } */

  // get brews stream
  Stream<List<Stat>> get stats {
    return firestore.collection(uid).snapshots().map(_statListFromSnapshot);
  }

  // get user doc stream
  /* Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  } */
}

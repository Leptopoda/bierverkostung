// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/models/stats.dart';
// import 'package:brew_crew/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  // final CollectionReference userCollection = FirebaseFirestore.instance.collection('uuid');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateUserData(DateTime date, double amount) async {
    firestore.collection(uid).add({
      'date': date,
      'amount': amount,
    });
  }

  // brew list from snapshot
  List<Stat> _statListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      // return Stat(menge: doc.data['amount'] ?? 0.0, timestamp: doc.data['date'] ?? '');
      print(doc.data());
      return Stat(menge: 0.0, timestamp: DateTime.now());
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

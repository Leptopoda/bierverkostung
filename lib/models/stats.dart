// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

import 'package:bierverkostung/models/beers.dart';

class Stat {
  // final String? id;
  // final int revision;
  final double menge;
  final DateTime timestamp;
  final Beer? beer;

  Stat({
    required this.menge,
    required this.timestamp,
    this.beer,
    //this.id,
  });

  factory Stat.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()!;

    return Stat(
      // id: doc.data(),
      menge: data['amount'] as double,
      timestamp: data['date'].toDate() as DateTime,
      beer: (data['beer'] != null)
          ? Beer(beerName: data['beer'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': timestamp,
      'amount': menge,
      'beer': beer?.beerName,
    };
  }
}

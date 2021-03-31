// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

class Stat {
  // final String? id;
  // final int revision;
  final double menge;
  final DateTime timestamp;

  Stat({
    required this.menge,
    required this.timestamp,
    //this.id,
  });

  factory Stat.fromMap(DocumentSnapshot doc) {
    return Stat(
      // id: doc.data(),
      menge: double.parse(doc['amount'].toString()),
      timestamp: DateTime.parse(doc['date'].toDate().toString()),
    );
  }
}

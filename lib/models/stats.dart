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
    final Map<String, dynamic> data = doc.data()!;

    return Stat(
      // id: doc.data(),
      menge: data['amount'] as double,
      timestamp: data['date'].toDate() as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': timestamp,
      'amount': menge,
    };
  }
}

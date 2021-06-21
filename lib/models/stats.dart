// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import 'package:bierverkostung/models/beers.dart';

part 'stats.g.dart';

@JsonSerializable()
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

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);

  factory Stat.fromMap(Map data) {
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

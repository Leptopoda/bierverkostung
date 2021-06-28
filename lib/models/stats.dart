// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import 'package:bierverkostung/models/beers.dart';

part 'stats.g.dart';

/// Sats data model
///
/// Holds the data needed for a beer stat
@JsonSerializable()
class Stat {
  // final String? id;
  // final int revision;
  final double amount;
  final DateTime timestamp;
  final Beer? beer;

  Stat({
    required this.amount,
    required this.timestamp,
    this.beer,
    //this.id,
  });

  /// decodes a Json into a [Stat] obbject
  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  /// encodes a Json style map from a [Stat] obbject
  Map<String, dynamic> toJson() => _$StatToJson(this);

  /// decodes a Json style map into a [Stat] obbject
  @Deprecated('use from and to json for en/decode')
  factory Stat.fromMap(Map data) {
    return Stat(
      // id: doc.data(),
      amount: data['amount'] as double,
      timestamp: data['date'].toDate() as DateTime,
      beer: (data['beer'] != null)
          ? Beer(beerName: data['beer'] as String)
          : null,
    );
  }

  /// encodes a Json style map into a [Stat] obbject
  @Deprecated('use from and to json for en/decode')
  Map<String, dynamic> toMap() {
    return {
      'date': timestamp,
      'amount': amount,
      'beer': beer?.beerName,
    };
  }
}

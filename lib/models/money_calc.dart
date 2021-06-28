// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'money_calc.g.dart';

/// MoneyCalc data model
///
/// holds the data used for a money calculation
@JsonSerializable()
class MoneyCalc {
  final String buyer;
  final double amount;
  final DateTime timestamp;
  // final List<String> participants;

  MoneyCalc({
    required this.buyer,
    required this.amount,
    required this.timestamp,
    // required this.participants,
  });

  /// decodes a Json into a [MoneyCalc] obbject
  factory MoneyCalc.fromJson(Map<String, dynamic> json) =>
      _$MoneyCalcFromJson(json);

  /// encodes a Json from a [MoneyCalc] obbject
  Map<String, dynamic> toJson() => _$MoneyCalcToJson(this);
}

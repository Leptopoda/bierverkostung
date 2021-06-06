// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'money_calc.g.dart';

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

  factory MoneyCalc.fromJson(Map<String, dynamic> json) =>
      _$MoneyCalcFromJson(json);
  Map<String, dynamic> toJson() => _$MoneyCalcToJson(this);
}

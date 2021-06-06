// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_calc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyCalc _$MoneyCalcFromJson(Map<String, dynamic> json) {
  return MoneyCalc(
    buyer: json['buyer'] as String,
    amount: (json['amount'] as num).toDouble(),
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$MoneyCalcToJson(MoneyCalc instance) => <String, dynamic>{
      'buyer': instance.buyer,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
    };

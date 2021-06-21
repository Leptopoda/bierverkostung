// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    menge: (json['menge'] as num).toDouble(),
    timestamp: DateTime.parse(json['timestamp'] as String),
    beer: json['beer'] == null
        ? null
        : Beer.fromJson(json['beer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'menge': instance.menge,
      'timestamp': instance.timestamp.toIso8601String(),
      'beer': instance.beer,
    };

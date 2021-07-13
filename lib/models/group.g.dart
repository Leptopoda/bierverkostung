// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    count: json['count'] as int,
    members:
        (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'members': instance.members,
      'count': instance.count,
      'name': instance.name,
    };

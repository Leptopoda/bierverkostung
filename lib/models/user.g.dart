// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
    uid: json['uid'] as String,
    guid: json['guid'] as String?,
    photoURL: json['photoURL'] as String?,
    email: json['email'] as String?,
    displayName: json['displayName'] as String?,
    isAnon: json['isAnon'] as bool,
  );
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'guid': instance.guid,
      'photoURL': instance.photoURL,
      'email': instance.email,
      'displayName': instance.displayName,
      'isAnon': instance.isAnon,
    };

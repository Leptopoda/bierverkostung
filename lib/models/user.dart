// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User data model
///
/// we used to store user information in here but
/// fully migrated to the [User] object
@JsonSerializable()
@immutable
class UserData {
  final String uid;
  final String? guid;
  final String? photoURL;
  final String? email;
  final String? displayName;
  final bool isAnon;

  const UserData({
    required this.uid,
    this.guid,
    this.photoURL,
    this.email,
    this.displayName,
    required this.isAnon,
  });

  /// encodes a Json style map into a [UserData] obbject
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  /// decodes a Json from a [UserData] obbject
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  /// returns a modifies userData object
  UserData copyWith({
    String? uid,
    String? guid,
    String? photoURL,
    String? email,
    String? displayName,
    bool? isAnon,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      guid: guid ?? this.guid,
      photoURL: photoURL ?? this.photoURL,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      isAnon: isAnon ?? this.isAnon,
    );
  }

  String get nameToDisplay => displayName ?? email ?? uid;
}

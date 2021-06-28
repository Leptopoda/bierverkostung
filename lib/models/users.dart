// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

/// User data model
///
/// we used to store user information in here but
/// fully migrated to the [FirebaseUser] object
@Deprecated(
    'Well start transition to the firebase user as we do not need extra info ')
class UserData {
  final String uid;
  final String guid;
  bool isAnon;

  UserData({
    required this.uid,
    required this.guid,
    this.isAnon = false,
  });

  /// decodes a Json style map into a [UserData] obbject
  factory UserData.fromMap(Map<String, dynamic> doc) {
    return UserData(
      uid: doc['user_id'] as String,
      // it will be the same eventually
      guid: (doc['group_id'] != null)
          ? doc['group_id'] as String
          : doc['user_id'] as String,
    );
  }

  /// encodes [UserData] obbject into a Json style map
  Map<String, dynamic> toMap() {
    return {
      'info': {
        'user_id': uid,
        'guid_id': guid,
      }
    };
  }
}

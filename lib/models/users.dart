// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

class UserData {
  final String uid;
  final String guid;

  UserData({
    required this.uid,
    required this.guid,
  });

  factory UserData.fromMap(Map<String, dynamic> doc) {
    return UserData(
      uid: doc['user_id'] as String,
      // it will be the same eventually
      guid: (doc['group_id'] != null)
          ? doc['group_id'] as String
          : doc['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'info': {
        'user_id': uid,
        'guid_id': guid,
      }
    };
  }
}

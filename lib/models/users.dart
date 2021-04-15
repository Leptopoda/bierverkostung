// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid;
  final String guid;

  UserData({
    required this.uid,
    required this.guid,
  });

  factory UserData.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()!;

    return UserData(
      uid: data['uid'] as String,
      guid: data['guid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'guid': guid,
    };
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

class User {
  final String uid;

  User({required this.uid});
}

class UserData {
  final String uid;
  final String group;

  UserData({
    required this.uid,
    required this.group,
  });
}

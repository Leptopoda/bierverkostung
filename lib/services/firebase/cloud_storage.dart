// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_storage/firebase_storage.dart';
import 'auth.dart';

class CloudStorageService {
  String? groupID;
  CloudStorageService({this.groupID});
  // Firestore instance
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final User user2 = AuthService().getUser()!;

  Future<String?> uploadProfile(Uint8List image) async {
    try {
      final Reference _ref = _storage.ref('${user2.uid}/profile.png');
      await _ref.putData(image);
      final String _downloadURL = await _ref.getDownloadURL();
      return _downloadURL;
    } on FirebaseException catch (e) {
      developer.log(
        'Get camera image',
        name: 'leptopoda.bierverkostung.camera',
        error: jsonEncode(e.toString()),
      );
    }
  }
}

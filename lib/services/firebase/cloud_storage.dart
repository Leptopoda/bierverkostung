// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'dart:io' show File;
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_storage/firebase_storage.dart';
import 'auth.dart';

class CloudStorageService {
  final String? groupID;
  const CloudStorageService({this.groupID});
  // Firestore instance
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final User user2 = AuthService.getUser()!;

  static Future<String?> uploadProfile(dynamic image) async {
    assert(image is Uint8List || image is File);

    try {
      final Reference _ref = _storage.ref('${user2.uid}/profile.png');
      if (image is File) {
        await _ref.putFile(image);
      } else if (image is Uint8List) {
        await _ref.putData(image);
      } else {
        ArgumentError();
      }
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

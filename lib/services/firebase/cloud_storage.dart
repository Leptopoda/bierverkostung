// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:bierverkostung/services/firebase/auth.dart';

/// Helpers to upload files to the Firebase cloud storage.
class CloudStorageService {
  const CloudStorageService._();

  /// CloudSotrage instance
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final User _user = AuthService.getUser!;
  static final String _groupID = AuthService.groupID;

  /// Uploads the file [image] to FirebaseStorage.
  /// It returns a future containing a download url.
  static Future<String?> uploadProfile(dynamic image) async {
    assert(image is Uint8List || image is File);

    try {
      final Reference _ref = _storage.ref('/users/${_user.uid}/profile.png');
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
        'uploading profile',
        name: 'leptopoda.bierverkostung.storageService',
        error: jsonEncode(e.toString()),
      );
    }
  }

  /// Uploads the file at a given [path] into the subfolder [beerName]
  /// on FirebaseStorage. It returns a future containing a download url.
  static Future<String?> uploadBeerImage(String path, String beerName) async {
    try {
      final String _uuid = const Uuid().v1();
      final Reference _ref = _storage.ref('/groups/$_groupID/$beerName/$_uuid');

      if (kIsWeb) {
        await _ref.putData(await PickedFile(path).readAsBytes());
      } else {
        await _ref.putFile(File(path));
      }

      final String _downloadURL = await _ref.getDownloadURL();

      return _downloadURL;
    } catch (e) {
      developer.log(
        'uploading beer image',
        name: 'leptopoda.bierverkostung.storageService',
        error: jsonEncode(e.toString()),
      );
    }
  }
}

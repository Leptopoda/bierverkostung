// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_functions/cloud_functions.dart';

/// Helpers for handling CloudFunctions.
class CloudFunctionsService {
  const CloudFunctionsService();

  /// FirebaseFunctions reference
  static final FirebaseFunctions _functions =
      FirebaseFunctions.instanceFor(region: 'europe-west3');

  /// calls a cloud function to add user [uid] to group [guid]
  static Future<HttpsCallableResult<dynamic>> setGroup(
      {required String uid, required String guid}) async {
    final HttpsCallable callable = _functions.httpsCallable('addGroup');
    final result = await callable({'uid': uid, 'guid': guid});
    //List fruit = results.data;  // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    return result;
  }

  /// calls a cloud function to remove the user [uid] from their current group
  static Future<HttpsCallableResult<dynamic>> removeGroup(String uid) async {
    final HttpsCallable callable = _functions.httpsCallable('removeGroup');
    final result = await callable({'uid': uid});
    return result;
  }
}

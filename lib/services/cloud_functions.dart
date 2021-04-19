// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<HttpsCallableResult<dynamic>> setGroup(String uid, String guid) async {
    final HttpsCallable callable = _functions.httpsCallable('addGroup');
    final result = await callable({'uid': uid, 'guid': guid});
    //List fruit = results.data;  // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    return result;
  }
}

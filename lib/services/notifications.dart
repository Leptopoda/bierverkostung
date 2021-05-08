// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/database.dart';

import 'package:bierverkostung/shared/constants.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService();

  //final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> askPermission(UserData user) async {
    await _fcm.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    final String? _token = await _fcm.getToken(vapidKey: vapidKey);
    if (_token != null) {
      await DatabaseService(user: user).saveNotificationToken({
        'token': _token,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': kIsWeb ? 'Web' : Platform.operatingSystem,
      });
    }
  }
}

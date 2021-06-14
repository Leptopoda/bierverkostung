// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/firebase/database.dart';

import 'package:bierverkostung/shared/constants.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> askPermission() async {
    await _fcm.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    final String? _token = await _fcm.getToken(vapidKey: vapidKey);
    if (_token != null) {
      await DatabaseService().saveNotificationToken({
        'token': _token,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': kIsWeb ? 'Web' : Platform.operatingSystem,
      });
    }
  }

  Future initialise() async {
    // TODO: fix duplicate refreshing

    // Get any messages which caused the application to open from
    // a terminated state.
    final RemoteMessage? initialMessage = await _fcm.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    if (initialMessage?.data['auth_refresh'] == 'true') {
      AuthService().refreshToken();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['auth_refresh'] == 'true') {
        AuthService().refreshToken();
      }
    });
  }
}

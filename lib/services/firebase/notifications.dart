// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/firebase/database.dart';

import 'package:flutter/foundation.dart';

/// Helpers for managing FCM Notifications.
class NotificationService {
  const NotificationService();

  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static const String _vapidKey =
      'BHzfRAVeY69M7uwBIzm8xiMaIZ0iDEbX9dgyvp87GKWWmlbXSt3arsWe9lQpjKF-OSM1RtOFTGnGrk-qnrYvF3s';

  /// ask the user for permission to send notifications
  static Future<void> askPermission() async {
    await _fcm.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    final String? _token = await _fcm.getToken(vapidKey: _vapidKey);
    if (_token != null) {
      await DatabaseService.saveNotificationToken({
        'token': _token,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': kIsWeb ? 'Web' : Platform.operatingSystem,
      });
    }
  }

  /// feches the the missed messages
  static Future initialise() async {
    // TODO: fix duplicate refreshing

    // Get any messages which caused the application to open from
    // a terminated state.
    final RemoteMessage? initialMessage = await _fcm.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    if (initialMessage?.data['auth_refresh'] == 'true') {
      AuthService.refreshToken();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['auth_refresh'] == 'true') {
        AuthService.refreshToken();
      }
    });
  }
}

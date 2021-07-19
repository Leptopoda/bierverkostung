// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:bierverkostung/services/navigation/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/group.dart';

part 'package:bierverkostung/screens/conference/conference.dart';

/// Helpers for managing [JitsiMeet] Conferences
class ConferenceService {
  const ConferenceService._();

  /// starts a new [JitsiMeet] conference
  /// on mobile this will start jitsi with its 'native' implementation
  /// on web this will automatically navigate to a new screen containing the conference

  static final JitsiMeetingListener _listener = JitsiMeetingListener(
    onConferenceWillJoin: _onConferenceWillJoin,
    onConferenceJoined: _onConferenceJoined,
    onConferenceTerminated: _onConferenceTerminated,
    onError: _onError,
    genericListeners: [
      JitsiGenericListener(
        eventName: 'readyToClose',
        callback: (dynamic message) {
          debugPrint("readyToClose callback");
        },
      ),
    ],
  );

  static Future<void> startMeeting(BuildContext context) async {
    if (kIsWeb) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const _WebMeeting(),
        ),
      );
    }
    final JitsiMeetingOptions? config = await showDialog<JitsiMeetingOptions>(
      context: context,
      builder: (_) => const _MeetingJoinAlert(),
    );

    if (config != null) {
      _joinMeeting(config);
    }
  }

  /// logs the joining process
  static void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  /// logs the joined state
  static void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  /// logs the terminated meeting status
  static void _onConferenceTerminated(message) {
    NavigationService.navigatorKey.currentState?.popAndPushNamed('/');

    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  /// logs generic errors
  static void _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  /// joins the meeting given by the [options]
  static Future<JitsiMeetingResponse> _joinMeeting(
      JitsiMeetingOptions options) async {
    return JitsiMeet.joinMeeting(
      options,
      listener: _listener,
    );
  }
}

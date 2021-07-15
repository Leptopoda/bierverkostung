// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:bierverkostung/models/group.dart';
import 'package:bierverkostung/services/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import 'package:bierverkostung/services/firebase/auth.dart';

/// Button opening the screen for a new meeting
@Deprecated('we directly implemented it into the [Home] screen')
class MeetingButton extends StatelessWidget {
  const MeetingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.call_outlined),
      tooltip: 'Conference',
      onPressed: () {
        Navigator.pushNamed(context, '/Conference');
      },
    );
  }
}

/// Meting View
///
/// Screen to start or join a Conference
class MeetingJoinAlert extends StatefulWidget {
  const MeetingJoinAlert({Key? key}) : super(key: key);

  @override
  _MeetingJoinAlertState createState() => _MeetingJoinAlertState();
}

class _MeetingJoinAlertState extends State<MeetingJoinAlert> {
  bool? _isAudioOnly = false;
  bool? _isAudioMuted = true;
  bool? _isVideoMuted = false;

  //@override
  //void initState() {
  //  super.initState();
  //  JitsiMeet.addListener(
  //    JitsiMeetingListener(
  //      onConferenceWillJoin: _onConferenceWillJoin,
  //      onConferenceJoined: _onConferenceJoined,
  //      onConferenceTerminated: _onConferenceTerminated,
  //      onError: _onError,
  //    ),
  //  );
  //}
  //
  //@override
  //void dispose() {
  //  super.dispose();
  //  JitsiMeet.removeAllListeners();
  //}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join Conference'),
      content: meetConfig(),
    );
  }

  /// returns the settings disloge for the meeting
  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: _isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: _isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: _isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                final JitsiMeetingOptions options = await _configureMeeting();
                //if (kIsWeb) {
                // await _joinMeeting(options);
                Navigator.pop(context, options);
                //} else {
                //  await _joinMeeting(options);
                //}
              },
              icon: const Icon(Icons.call_outlined),
              label: Text(AppLocalizations.of(context)!
                  .settings_groupManagement_leaveGroup),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  /// sets the [audioOnly] parameter
  void _onAudioOnlyChanged(bool? value) {
    setState(() {
      _isAudioOnly = value;
    });
  }

  /// sets the [audioMuted] parameter
  void _onAudioMutedChanged(bool? value) {
    setState(() {
      _isAudioMuted = value;
    });
  }

  /// sets the [videoMuted] parameter
  void _onVideoMutedChanged(bool? value) {
    setState(() {
      _isVideoMuted = value;
    });
  }

  /// joins or starts the meeting
  Future<JitsiMeetingOptions> _configureMeeting() async {
    // final Group _groupData = await DatabaseService.group;
    final String _roomText = "beertasting_${AuthService.groupID}";
    final String _subjectText =
        "Beertasting "; // ${_groupData.name ?? AuthService.getUser!.displayName ?? ''}
    final String? _nameText = AuthService.getUser?.displayName;
    final String? _emailText = AuthService.userEmail;

    final ThemeData _theme = Theme.of(context);
    final ColorScheme _colorScheme = _theme.colorScheme;
    final Color _appBar = _theme.appBarTheme.backgroundColor ??
        (_colorScheme.brightness == Brightness.dark
            ? _colorScheme.surface
            : _colorScheme.primary);

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    final Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }

    // Define meetings options here
    final options = JitsiMeetingOptions(room: _roomText)
      ..serverURL = null
      ..subject = _subjectText
      ..userDisplayName = _nameText
      ..userEmail = _emailText
      ..iosAppBarRGBAColor = '#${_appBar.value.toRadixString(16)}'
      ..audioOnly = _isAudioOnly
      ..audioMuted = _isAudioMuted
      ..videoMuted = _isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": _roomText,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": _nameText}
      };

    debugPrint("JitsiMeetingOptions: $options");

    return options;
  }

  /// joins or starts the meeting
  static Future<JitsiMeetingResponse> _joinMeeting(
      JitsiMeetingOptions options) async {
    return JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        },
        onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        },
        onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
        },
        genericListeners: [
          JitsiGenericListener(
            eventName: 'readyToClose',
            callback: (dynamic message) {
              debugPrint("readyToClose callback");
            },
          ),
        ],
      ),
    );
  }

  ///// logs the joining process
  //static void _onConferenceWillJoin(message) {
  //  debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  //}
  //
  ///// logs the joined state
  //static void _onConferenceJoined(message) {
  //  debugPrint("_onConferenceJoined broadcasted with message: $message");
  //}
  //
  ///// logs the terminated meeting status
  //static void _onConferenceTerminated(message) {
  //  debugPrint("_onConferenceTerminated broadcasted with message: $message");
  //}
  //
  ///// logs generic errors
  //static void _onError(error) {
  //  debugPrint("_onError broadcasted: $error");
  //}
}

/// Meting View
///
/// Screen to start or join a Conference
class WebMeeting extends StatefulWidget {
  //final JitsiMeetingOptions options;
  const WebMeeting({
    //  required this.options,
    Key? key,
  }) : super(key: key);

  @override
  _WebMeetingState createState() => _WebMeetingState();
}

class _WebMeetingState extends State<WebMeeting> {
  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(
      JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError,
      ),
    );
    // WidgetsBinding.instance
    //     ?.addPostFrameCallback((_) => _joinMeeting(widget.options));
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    /* return FutureBuilder(
        future: ,
        builder: (BuildContext context,
            AsyncSnapshot<JitsiMeetingOptions?> snapshot) { */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conference (Alpha)'),
        actions: [
          IconButton(
            onPressed: () => {/* _joinMeeting(widget.options) */},
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white54,
            child: JitsiMeetConferencing(
              extraJS: const [
                // extraJs setup example
                // '<script>function echo(){console.log("echo!!!")};</script>',
                '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
              ],
            ),
          ),
        ),
      ),
    );
    /* }); */
  }

  static Future<JitsiMeetingResponse> _joinMeeting(
      JitsiMeetingOptions options) async {
    return JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        },
        onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        },
        onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
        },
        genericListeners: [
          JitsiGenericListener(
            eventName: 'readyToClose',
            callback: (dynamic message) {
              debugPrint("readyToClose callback");
            },
          ),
        ],
      ),
    );
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
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  /// logs generic errors
  static void _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}

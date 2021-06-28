import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

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
class Meeting extends StatefulWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conference (Alpha)'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.30,
                    child: meetConfig(),
                  ),
                  SizedBox(
                    width: width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: width * 0.60 * 0.70,
                          height: width * 0.60 * 0.70,
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
                  ),
                ],
              )
            : meetConfig(),
      ),
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
          TextField(
            controller: serverText,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Server URL",
                hintText: "Hint: Leave empty for meet.jitsi.si"),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: roomText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Room",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: subjectText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Subject",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: nameText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Display Name",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: emailText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: iosAppBarRGBAColor,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "AppBar Color(IOS only)",
              hintText: "Hint: This HAS to be in HEX RGBA format",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: const Text(
                "Join Meeting",
              ),
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
      isAudioOnly = value;
    });
  }

  /// sets the [audioMuted] parameter
  void _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  /// sets the [videoMuted] parameter
  void _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  /// joins or starts the meeting
  Future<void> _joinMeeting() async {
    final String? serverUrl =
        serverText.text.trim().isEmpty ? null : serverText.text;

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
    final options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = serverUrl
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
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
                }),
          ]),
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

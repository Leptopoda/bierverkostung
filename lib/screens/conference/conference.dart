// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/services/conference_service.dart';

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
/// Screen to start or join a Conference.
/// It pops with the selected [JitsiMeetingOptions]
class _MeetingJoinAlert extends StatefulWidget {
  const _MeetingJoinAlert({Key? key}) : super(key: key);

  @override
  _MeetingJoinAlertState createState() => _MeetingJoinAlertState();
}

class _MeetingJoinAlertState extends State<_MeetingJoinAlert> {
  bool? _isAudioOnly = false;
  bool? _isAudioMuted = true;
  bool? _isVideoMuted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).conference_joinCall),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context).conference_audioOnly),
              value: _isAudioOnly,
              onChanged: _onAudioOnlyChanged,
            ),
            const SizedBox(
              height: 14.0,
            ),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context).conference_audioMuted),
              value: _isAudioMuted,
              onChanged: _onAudioMutedChanged,
            ),
            const SizedBox(
              height: 14.0,
            ),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context).conference_videoMuted),
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
                onPressed: () async {
                  final JitsiMeetingOptions options = await _configureMeeting();

                  Navigator.pop(context, options);
                },
                icon: const Icon(Icons.call_outlined),
                label: Text(AppLocalizations.of(context).conference_joinCall),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
          ],
        ),
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

  /// configures the meeting by setting the [JitsiMeetingOptions]
  Future<JitsiMeetingOptions> _configureMeeting() async {
    final Group _groupData = await DatabaseService.group;
    final String _roomText = AppLocalizations.of(context)
        .conference_roomNamePrefix(AuthService.groupID);
    final String _subjectText = AppLocalizations.of(context)
        .conference_callNamePrefix(
            _groupData.name ?? AuthService.getUser!.displayName ?? '');
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
}

/// Meting Web View
///
/// Screen showing the conference on the Web
class _WebMeeting extends StatefulWidget {
  const _WebMeeting({Key? key}) : super(key: key);

  @override
  _WebMeetingState createState() => _WebMeetingState();
}

class _WebMeetingState extends State<_WebMeeting> {
  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).conference),
      ),
      body: JitsiMeetConferencing(extraJS: const []),
    );
  }
}

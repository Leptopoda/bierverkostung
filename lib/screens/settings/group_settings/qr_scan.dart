// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/group_settings/group_management.dart';

/// QR scanner fragment
///
/// this screen implements a QR scanner used for adding users to your own group
class _QRScanner extends StatefulWidget {
  const _QRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<_QRScanner> {
  QRViewController? controller;
  static final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    final double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 250.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_qrScan_scan),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).accentColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
        ),
      ),
      bottomSheet: kIsWeb ? null : _BottomBar(controller: controller),
    );
  }

  /// callback function needed by QRScanner
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      try {
        final Map _userScanned = jsonDecode(scanData.code) as Map;
        final String? _userID = _userScanned['user'] as String?;
        if (_userID != null && _userID.length == 28) {
          await controller.pauseCamera();
          await _showAlert(_userID, context);
          await controller.resumeCamera();
        }
      } catch (error) {
        developer.log(
          'error parsing json',
          name: 'leptopoda.bierverkostung.QRViewExample',
          error: jsonEncode(error.toString()),
        );
      }
    });
  }

  /// displays an alert asking for confirmation to add the current user
  /// it will also call [_addGroup()] to addd the displayed user
  static Future<Widget?> _showAlert(String userID, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext _) => AlertDialog(
        title: Text(
            AppLocalizations.of(context)!.settings_groupManagement_addToGroup),
        content:
            Text(AppLocalizations.of(context)!.settings_qrScan_alert(userID)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.alert_escape),
          ),
          TextButton(
            onPressed: () => _addGroup(userID, context),
            child: Text(AppLocalizations.of(context)!.alert_continue),
          ),
        ],
      ),
    );
  }

  /// adds the user identified by [userID] to the callers current group
  static Future<void> _addGroup(String userID, BuildContext context) async {
    final String _groupID = AuthService.groupID;

    final HttpsCallableResult<dynamic> result =
        await CloudFunctionsService.setGroup(userID, _groupID);
    // TODO: popAndPushNamed to avoid reloading of the camera
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.data.toString()),
      ),
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }
}

/// Bottom bar widget
///
/// This widget contains the camera Controlls UI like flash settings or rotate camera.
class _BottomBar extends StatelessWidget {
  final QRViewController? controller;
  const _BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _FlashButton(
          controller: controller,
        ),
        const SizedBox(width: 40),
        _CameraButton(
          controller: controller,
        ),
      ],
    );
  }
}

/// Flash button
class _FlashButton extends StatefulWidget {
  final QRViewController? controller;
  const _FlashButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _FlashButtonState createState() => _FlashButtonState();
}

class _FlashButtonState extends State<_FlashButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)?.settings_groupManagement_flash,
      icon: FutureBuilder(
        future: widget.controller?.getFlashStatus(),
        builder: (context, AsyncSnapshot<bool?> snapshot) {
          return (snapshot.data != null && snapshot.data!)
              ? const Icon(Icons.flash_on_outlined, size: 40)
              : const Icon(Icons.flash_off_outlined, size: 40);
        },
      ),
      onPressed: () async {
        await widget.controller?.toggleFlash();
        setState(() {});
      },
    );
  }
}

/// Rotate Camera button
class _CameraButton extends StatelessWidget {
  final QRViewController? controller;
  const _CameraButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip:
          AppLocalizations.of(context)?.settings_groupManagement_orientation,
      icon: const Icon(Icons.flip_camera_android_outlined, size: 40),
      onPressed: () => controller?.flipCamera(),
    );
  }
}

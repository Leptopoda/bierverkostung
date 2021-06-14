// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart' show HttpsCallableResult;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/firebase/cloud_functions.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  static final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_qrScan_scan),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: <Widget>[
                Expanded(child: _buildQrView(context)),
                SizedBox(
                  height: 100,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _flashButton(),
                        _cameraButton(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: <Widget>[
                Expanded(child: _buildQrView(context)),
                if (!kIsWeb)
                  SizedBox(
                    width: 100,
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _flashButton(),
                          _cameraButton(),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _flashButton() {
    return IconButton(
      icon: FutureBuilder(
        future: controller?.getFlashStatus(),
        builder: (context, snapshot) {
          return (snapshot.data != null && snapshot.data! as bool)
              ? const Icon(Icons.flash_on_outlined)
              : const Icon(Icons.flash_off_outlined);
        },
      ),
      onPressed: () async {
        await controller?.toggleFlash();
        setState(() {});
      },
    );
  }

  Widget _cameraButton() {
    return IconButton(
      icon: const Icon(Icons.flip_camera_android_outlined),
      onPressed: () => controller?.flipCamera(),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    final double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 250.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).accentColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

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

  static Future<void> _addGroup(String userID, BuildContext context) async {
    final String? _groupID = await AuthService.getClaim('group_id') as String?;
    if (_groupID != null) {
      final HttpsCallableResult<dynamic> result =
          await CloudFunctionsService.setGroup(userID, _groupID);
      // TODO: popAndPushNamed to avoid reloading of the camera
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.data.toString()),
        ),
      );
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

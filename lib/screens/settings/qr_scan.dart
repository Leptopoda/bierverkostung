// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonDecode;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:cloud_functions/cloud_functions.dart' show HttpsCallableResult;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/cloud_functions.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
        title: const Text('Scan a code'),
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
        final String? _userID = _userScanned['info']['user_id'] as String?;
        if (_userID != null && _userID.length == 28) {
          await controller.pauseCamera();
          await _showAlert(_userID);
          await controller.resumeCamera();
        }
      } catch (e) {
        print('error $e');
      }
    });
  }

  Future<Widget?> _showAlert(String userID) {
    return showDialog(
      context: context,
      builder: (BuildContext _) => AlertDialog(
        title: const Text('Zur Gruppe hinzufügen'),
        content: Text(
          'Soll der gescante Nutzer $userID der Gruppe hinzugefügt werden?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbruch'),
          ),
          TextButton(
            onPressed: () async {
              final UserData _user =
                  Provider.of<UserData?>(context, listen: false)!;
              final HttpsCallableResult<dynamic> result =
                  await CloudFunctionsService().setGroup(userID, _user.guid);
              // TODO: popAndPushNamed to avoid reloading of the camera
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.data.toString()),
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Weiter'),
          ),
        ],
      ),
    );
  }
}

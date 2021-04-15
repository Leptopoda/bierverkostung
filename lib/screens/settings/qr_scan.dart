// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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

  Widget _playButton() {
    return IconButton(
      icon: const Icon(Icons.pause),
      onPressed: () async {
        await controller?.pauseCamera();
      },
    );
  }

  Widget _pasueButton() {
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      onPressed: () async {
        await controller?.resumeCamera();
      },
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
      // TODO: check validity of scanned code
      await controller.pauseCamera();
      await _showAlert(scanData.code);
      await controller.resumeCamera();
    });
  }

  Future<Widget?> _showAlert(String data) {
    return showDialog(
      context: context,
      builder: (BuildContext _) => AlertDialog(
        title: const Text('Zur Gruppe hinzufügen'),
        content: Text(
          'Soll der gescante Nutzer $data der Gruppe hinzugefügt werden?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbruch'),
          ),
          TextButton(
            onPressed: () async {
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

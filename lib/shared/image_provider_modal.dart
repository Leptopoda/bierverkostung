// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Image picker bottom modal
///
/// Allows you to pick image from either the gallery or the camera
/// camera is only supported on iOS or ANdroid.
/// If provided [removeCallback] will activate an option to
/// delete the image calling the given callback method
class PickImageModal extends StatelessWidget {
  final Function? removeCallback;
  const PickImageModal({
    Key? key,
    this.removeCallback,
  }) : super(key: key);

  /// The used theme providing rounded corners
  static const shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).settings_userManagement_choosePhoto,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (!kIsWeb)
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(AppLocalizations.of(context)
                    .settings_userManagement_takePhoto),
                onTap: () => _getCameraImage(context),
              ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(AppLocalizations.of(context)
                  .settings_userManagement_chooseGallery),
              onTap: () => _getGalleryImage(context),
            ),
            if (removeCallback != null)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded),
                title: Text(AppLocalizations.of(context)
                    .settings_userManagement_removePhoto),
                onTap: () {
                  Navigator.pop(context);
                  removeCallback!();
                },
              ),
          ],
        ),
      ),
    );
  }

  /// gets an image from the camera
  static Future<void> _getCameraImage(BuildContext context) async {
    PickedFile? _pickedFile;
    try {
      _pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
    } catch (error) {
      developer.log(
        'Get camera image',
        name: 'leptopoda.bierverkostung.camera',
        error: jsonEncode(error.toString()),
      );
    }

    Navigator.pop(context, _pickedFile?.path);
  }

  /// gets an image from the gallery or file
  static Future<void> _getGalleryImage(BuildContext context) async {
    PickedFile? _pickedFile;
    try {
      _pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
    } catch (error) {
      developer.log(
        'Get gallery image',
        name: 'leptopoda.bierverkostung.camera',
        error: jsonEncode(error.toString()),
      );
    }

    Navigator.pop(context, _pickedFile?.path);
  }
}

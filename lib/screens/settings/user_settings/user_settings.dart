// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:crop_image/crop_image.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bierverkostung/services/firebase/cloud_storage.dart';
import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/shared/image_provider_modal.dart';
import 'package:bierverkostung/shared/error_page.dart';

part 'package:bierverkostung/screens/settings/user_settings/crop_profile.dart';
part 'package:bierverkostung/screens/settings/user_settings/logout_alert.dart';
part 'package:bierverkostung/screens/settings/user_settings/logout_alert_anon.dart';

/// Settings screen for managing the current User
///
/// This screen lets the user manipulate it's profile data or sign out
class UserSettings extends StatelessWidget {
  const UserSettings({Key? key}) : super(key: key);

  static final User user = AuthService.getUser!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 30),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: (user.photoURL != null)
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: (user.photoURL == null)
                        ? const Icon(
                            Icons.person_outline,
                            size: 50,
                          )
                        : null,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 15,
                        padding: EdgeInsets.zero,
                        splashRadius: 18,
                        tooltip: AppLocalizations.of(context)!
                            .settings_userManagement_changeProfile,
                        onPressed: () => _changeAvatar(context),
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextFormField(
                style: Theme.of(context).textTheme.subtitle2,
                initialValue: user.displayName ?? user.uid,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .settings_userManagement_username,
                  suffixIcon: const Icon(Icons.edit_outlined),
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (String? value) {
                  user.updateDisplayName(value);
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(
              user.email ?? AppLocalizations.of(context)!.login_anonymous,
              style: Theme.of(context).textTheme.caption,
            ),
            /* const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                primary: Theme.of(context).accentColor,
              ),
              onPressed: () => {},
              child: const Text('Upgrade to Pro'),
            ), */
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext _) => (AuthService.getUser!.isAnonymous)
                    ? const _LogOutAnonAlert()
                    : const _LogOutAlert(),
              ),
              icon: const Icon(Icons.logout_outlined),
              label: Text(AppLocalizations.of(context)!.settings_logOut),
            ),
          ],
        ),
      ),
    );
  }

  /// changes the current profile picture
  static Future<void> _changeAvatar(BuildContext context) async {
    final String? _path = await showModalBottomSheet<String?>(
      shape: PickImageModal.shape,
      context: context,
      builder: (BuildContext context) {
        return const PickImageModal(
          removeCallback: _deleteAvatar,
        );
      },
    );

    if (_path != null) {
      final dynamic _cropped = await _cropImage(context, _path);

      if (_cropped != null) {
        final String? _url = await CloudStorageService.uploadProfile(_cropped);
        if (_url != null) {
          user.updatePhotoURL(_url);
        }
      }
    }
  }

  /// crops the picture at [path] to a square
  static Future<dynamic> _cropImage(BuildContext context, String path) async {
    if (kIsWeb) {
      return Navigator.push<Uint8List?>(
        context,
        MaterialPageRoute<Uint8List?>(
          builder: (BuildContext context) => _CropProfileWeb(
            imagePath: path,
          ),
        ),
      );
    } else {
      final ThemeData theme = Theme.of(context);
      final ColorScheme colorScheme = theme.colorScheme;
      return ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        cropStyle: CropStyle.circle,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle:
              AppLocalizations.of(context)?.settings_userManagement_cropImage,
          toolbarColor: theme.appBarTheme.backgroundColor ??
              (colorScheme.brightness == Brightness.dark
                  ? colorScheme.surface
                  : colorScheme.primary),
          toolbarWidgetColor: theme.appBarTheme.backgroundColor ??
              (colorScheme.brightness == Brightness.dark
                  ? colorScheme.onSurface
                  : colorScheme.onPrimary),
          backgroundColor: theme.scaffoldBackgroundColor,
          activeControlsWidgetColor: theme.accentColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          title:
              AppLocalizations.of(context)?.settings_userManagement_cropImage,
        ),
      );
    }
  }

  /// resets the profile picture to the standard one
  static Future<void> _deleteAvatar(BuildContext context) async {
    await user.updatePhotoURL(null);
    Navigator.pop(context);
  }
}

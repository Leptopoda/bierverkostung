// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:crop_image/crop_image.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bierverkostung/services/firebase/cloud_storage.dart';
import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/shared/image_provider_modal.dart';
import 'package:bierverkostung/shared/error_page.dart';

part 'crop_profile.dart';
part 'logout_alert.dart';
part 'logout_alert_anon.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({Key? key}) : super(key: key);

  static final User user = AuthService().getUser()!;

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
                    // backgroundColor: Colors.black,
                    // foregroundColor: Colors.white,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext _) =>
                    (AuthService().getUser()!.isAnonymous)
                        ? const _LogOutAnonAlert()
                        : const _LogOutAlert(),
              ),
              icon: const Icon(Icons.login_outlined),
              label: Text(AppLocalizations.of(context)!.settings_logOut),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _changeAvatar(BuildContext context) async {
    final String? _path = await showModalBottomSheet<String?>(
      context: context,
      builder: (BuildContext context) {
        return const PickImageModal(
          removeCallback: _deleteAvatar,
        );
      },
    );

    if (_path != null) {
      final Uint8List? _cropped = await Navigator.of(context).push<Uint8List?>(
        MaterialPageRoute<Uint8List?>(
          builder: (BuildContext context) => _CropProfile(
            imagePath: _path,
          ),
        ),
      );

      if (_cropped != null) {
        final String? _url =
            await CloudStorageService().uploadProfile(_cropped);
        if (_url != null) {
          user.updatePhotoURL(_url);
        }
      }
    }
  }

  static Future<void> _deleteAvatar(BuildContext context) async {
    await user.updatePhotoURL(null);
    Navigator.pop(context);
  }
}

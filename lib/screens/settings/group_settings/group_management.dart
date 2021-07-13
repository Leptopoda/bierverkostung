// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io' show Platform;
import 'package:bierverkostung/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_functions/cloud_functions.dart' show HttpsCallableResult;
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:qr_flutter/qr_flutter.dart' show QrImage;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/firebase/cloud_functions.dart';
import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';

part 'package:bierverkostung/screens/settings/group_settings/add_user.dart';
part 'package:bierverkostung/screens/settings/group_settings/group_members.dart';
part 'package:bierverkostung/screens/settings/group_settings/qr_scan.dart';

/// Settings screen for managing the current User
///
/// This screen lets the user manipulate it's profile data or sign out
class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  static final String _groupID = AuthService.groupID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Group>(
      stream: DatabaseService.group,
      builder: (BuildContext context, AsyncSnapshot<Group> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: snapshot.error.toString(),
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return Center(
                child: Text(AppLocalizations.of(context)!.beer_noBeers),
              );
            }

            final Group _groupData = snapshot.data!;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2,
                        initialValue: _groupData.name ?? _groupID,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .settings_groupManagement_groupName,
                          suffixIcon: const Icon(Icons.edit_outlined),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (String? value) {
                          _groupData.name = value;
                          DatabaseService.saveGroup(_groupData);
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!
                          .settings_groupManagement_memberCount(
                              _groupData.count),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        final bool? _confirmation = await showDialog<bool?>(
                          context: context,
                          builder: (_) => const _LeaveGroupDialog(),
                        );
                        if (_confirmation ?? false) {
                          await CloudFunctionsService.removeGroup(
                            AuthService.getUser!.uid,
                          );
                        }
                      },
                      icon: const Icon(Icons.logout_outlined),
                      label: Text(AppLocalizations.of(context)!
                          .settings_groupManagement_leaveGroup),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _AddUser(),
                        ),
                      ),
                      icon: const Icon(Icons.group_add_outlined),
                      label: Text(AppLocalizations.of(context)!
                          .settings_groupManagement_addUser),
                    ),
                    _GroupMemberList(members: _groupData.members),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

class _LeaveGroupDialog extends StatelessWidget {
  const _LeaveGroupDialog({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
          AppLocalizations.of(context)!.settings_groupManagement_leaveGroup),
      content: Text(
        AppLocalizations.of(context)!
            .settings_groupManagement_leaveGroup_description,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}

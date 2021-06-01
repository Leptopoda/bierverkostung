// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart' show HttpsCallableResult;
import 'package:qr_flutter/qr_flutter.dart' show QrImage;
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/cloud_functions.dart';
import 'package:bierverkostung/services/auth.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  final TextEditingController _uid = TextEditingController();
  final TextEditingController _newUser = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _uid.dispose();
    _newUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User _user = AuthService().getUser()!;
    _uid.text = _user.uid;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            style: _text,
            readOnly: true,
            controller: _uid,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.settings_groupManagement_yourID,
              suffixIcon: const Icon(Icons.group_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => _scanQR(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: Container(
                height: 230,
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    QrImage(
                      data: jsonEncode({'user': _user.uid}),
                      size: 175.0,
                    ),
                    Text(AppLocalizations.of(context)!
                        .settings_groupManagement_scanCode),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: _text,
            controller: _newUser,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.settings_groupManagement_uid,
              suffixIcon: const Icon(Icons.person_outline),
            ),
            validator: (value) => (value == null || value.length != 28)
                ? AppLocalizations.of(context)!
                    .settings_groupManagement_invalidUid
                : null,
          ),
          ElevatedButton.icon(
            onPressed: () => _submit(context),
            icon: const Icon(Icons.group_add_outlined),
            label: Text(AppLocalizations.of(context)!
                .settings_groupManagement_addToGroup),
          ),
          ElevatedButton.icon(
            onPressed: () => AuthService().refreshToken(),
            icon: const Icon(Icons.refresh_outlined),
            label: Text(AppLocalizations.of(context)!
                .settings_groupManagement_refreshToken),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String? _groupID =
          await AuthService().getClaim('group_id') as String?;
      if (_groupID != null) {
        final HttpsCallableResult<dynamic> result =
            await CloudFunctionsService()
                .setGroup(_newUser.value.text, _groupID);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.data.toString()),
          ),
        );
      }
    }
  }

  void _scanQR() {
    Navigator.pushNamed(context, '/Settings/Groups/ScanCode');
  }
}

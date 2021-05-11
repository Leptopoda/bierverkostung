// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart' show Provider;
import 'package:cloud_functions/cloud_functions.dart' show HttpsCallableResult;
import 'package:qr_flutter/qr_flutter.dart' show QrImage;

import 'package:bierverkostung/models/users.dart';
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
    final UserData _user = Provider.of<UserData?>(context)!;
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
            decoration: const InputDecoration(
              labelText: 'Your ID',
              suffixIcon: Icon(Icons.group_outlined),
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
                      data: jsonEncode(_user.toMap()),
                      size: 175.0,
                    ),
                    const Text('press to scan'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: _text,
            controller: _newUser,
            decoration: const InputDecoration(
              labelText: 'User ID',
              suffixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) => (value == null || value.length != 28)
                ? 'Kein gültiger Nutzer'
                : null,
          ),
          ElevatedButton.icon(
            onPressed: () => _submit(context, _user),
            icon: const Icon(Icons.group_add_outlined),
            label: const Text('Add user to group'),
          ),
          ElevatedButton.icon(
            onPressed: () => AuthService().refreshToken(),
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Reload Status'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context, UserData _user) async {
    if (_formKey.currentState!.validate()) {
      final HttpsCallableResult<dynamic> result = await CloudFunctionsService()
          .setGroup(_newUser.value.text, _user.guid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.data.toString()),
        ),
      );
    }
  }

  void _scanQR() {
    if (!kIsWeb) {
      Navigator.pushNamed(context, '/Settings/Groups/ScanCode');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Only IOS and Android are currently supported for scanning QR codes'),
        ),
      );
    }
  }
}

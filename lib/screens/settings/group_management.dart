// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart' show QrImage;

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/models/users.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  final TextEditingController _guid = TextEditingController();

  @override
  void dispose() {
    _guid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService().user.listen((UserData? user) => {
          if (user != null) {_guid.text = user.guid}
        });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add groups'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            style: _text,
            readOnly: true,
            controller: _guid,
            decoration: const InputDecoration(
              labelText: 'Current Group',
              suffixIcon: Icon(Icons.group_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: QrImage(
              data: _guid.value.text,
              size: 200.0,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: _text,
            decoration: InputDecoration(
              labelText: 'User ID',
              suffixIcon: IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () => {
                  if (!kIsWeb)
                    {Navigator.pushNamed(context, '/Settings/Groups/ScanCode')}
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Only IOS and Android are currently supported for scanning QR codes'),
                        ),
                      )
                    }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

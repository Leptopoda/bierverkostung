// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart' show Provider;
import 'package:qr_flutter/qr_flutter.dart' show QrImage;

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/cloud_functions.dart';

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
  final TextEditingController _newUser = TextEditingController();

  @override
  void dispose() {
    _guid.dispose();
    _newUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserData _user = Provider.of<UserData?>(context)!;
    _guid.text = _user.guid;

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
              data: _user.toMap().toString(),
              size: 200.0,
              foregroundColor: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: _text,
            controller: _newUser,
            decoration: const InputDecoration(
              labelText: 'User ID',
              suffixIcon: Icon(Icons.person_outline),
              // Using iconButton as a decoration will also open the keyboard.
              // This will kill the device due to much load....
              /* IconButton(
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
              ), */
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => {
              if (!kIsWeb)
                {
                  Navigator.pushNamed(context, '/Settings/Groups/ScanCode'),
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Only IOS and Android are currently supported for scanning QR codes'),
                    ),
                  ),
                },
            },
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan code'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              final HttpsCallableResult<dynamic> result =
                  await CloudFunctionsService()
                      .setGroup(_newUser.value.text, _guid.value.text);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.data.toString()),
                ),
              );
            },
            icon: const Icon(Icons.group_add_outlined),
            label: const Text('Add user to group'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              FirebaseAuth.instance.currentUser!.getIdToken(true);
            },
            icon: const Icon(Icons.refresh_outlined),
            label: const Text('Reload Status'),
          ),
        ],
      ),
    );
  }
}

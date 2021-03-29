// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/services/auth.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if(result == null){
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result);
                }
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              child: const Text('Neue ID'),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => new NewIDAlert(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewIDAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Achtung!!'),
      content: new Text(
          'Folgendes wird eine Neue Nutzer ID anfragen. Jegliche Zugehörigkeit einer Grupper, oder gespeicherten Statistiken gehen dardurch verloren'),
      actions: <Widget>[
        TextButton(
          child: Text('Abbruch'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: Text('Weiter'),
            onPressed: () {
              print('R:I:P');
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

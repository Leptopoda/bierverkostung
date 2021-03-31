// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/auth.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 35),
            Text('You are currently logged in as ${_auth.getCurrentUid()}'),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('loged out '),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Log Out'),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const NewIDAlert(),
              ),
              child: const Text('Neue ID'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewIDAlert extends StatelessWidget {
  const NewIDAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Achtung!!'),
      content: const Text(
          'Folgendes wird eine Neue Nutzer ID anfragen. Jegliche Zugehörigkeit einer Grupper, oder gespeicherten Statistiken gehen dardurch verloren'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbruch'),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('R:I:P'),
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Weiter'),
        ),
      ],
    );
  }
}

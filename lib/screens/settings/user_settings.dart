// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/auth.dart';

class LogOutAlert extends StatelessWidget {
  const LogOutAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Achtung!!'),
      content: const Text(
        'Durch fortfahren wird der aktuelle benutzer abgemeldet. '
        'Wenn der aktuelle nutzer Annonym ist geht dardurch auch der zugriff auf die Daten verloren',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbruch'),
        ),
        TextButton(
          onPressed: () async {
            await AuthService().signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('loged out'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Weiter'),
        ),
      ],
    );
  }
}

/* class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
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
                builder: (BuildContext _) => const LogOutAlert(),
              ),
              child: const Text('Neue ID'),
            ),
          ],
        ),
      ),
    );
  }
} */

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/shared/error_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                final dynamic result = await _auth.registerAnon();
                if (result == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SomethingWentWrong(
                              error: 'error signing in',
                            )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('signed in $result')));
                }
              },
              child: const Text('Register Anonymously'),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const NewIDAlert(),
              ),
              child: const Text('Neue ID'),
            ),
            const SizedBox(height: 35),
            const AddBierverkostung(
                fullName: 'Nikolas Rimikis',
                company: 'Leptopoda Inc.',
                age: 18),
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
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('R:I:P')));
            Navigator.of(context).pop();
          },
          child: const Text('Weiter'),
        ),
      ],
    );
  }
}

class AddBierverkostung extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const AddBierverkostung(
      {Key? key,
      required this.fullName,
      required this.company,
      required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    Future<void> addVerkostung() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SomethingWentWrong(
                          error: 'Failed to add user: $error',
                        )),
              ));
    }

    return ElevatedButton(
      onPressed: addVerkostung,
      child: const Text(
        "Add User",
      ),
    );
  }
}

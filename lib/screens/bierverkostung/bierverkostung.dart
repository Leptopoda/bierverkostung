// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bierverkostung/shared/error_page.dart';

class Bierverkostung extends StatelessWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddBierverkostung(fullName: 'Nikolas Rimikis', company: 'Leptopoda Inc.', age: 18);
    // child: Center(child: Text('Bierverkostung')),
  }
}

class BierverkostungFab extends StatelessWidget {
  const BierverkostungFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => const BierverkostungAlert(),
      ),
      child: const Icon(Icons.add),
    );
  }
}

class BierverkostungAlert extends StatefulWidget {
  const BierverkostungAlert({Key? key}) : super(key: key);

  @override
  State<BierverkostungAlert> createState() => _BierverkostungAlertState();
}

class _BierverkostungAlertState extends State<BierverkostungAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Noch ein Bier"),
      content: const Text('TBA'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class AddBierverkostung extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const AddBierverkostung({Key? key, required this.fullName, required this.company, required this.age}) : super(key: key);

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

    return Center(
      child: ElevatedButton(
        onPressed: addVerkostung,
        child: const Text(
          "Add User",
        ),
      ),
    );
  }
}

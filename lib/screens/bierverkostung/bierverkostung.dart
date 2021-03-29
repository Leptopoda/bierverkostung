// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bierverkostung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AddBierverkostung('Nikolas Rimikis', 'Leptopoda inc', 18),
      // child: Center(child: Text('Bierverkostung')),
    );
  }
}

class BierverkostungFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => new BierverkostungAlert(),
      ),
      child: Icon(Icons.add),
    );
  }
}

class BierverkostungAlert extends StatefulWidget {
  @override
  State<BierverkostungAlert> createState() => _BierverkostungAlertState();
}

class _BierverkostungAlertState extends State<BierverkostungAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Noch ein Bier"),
      content: new Text('TBA'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: Text('Submit'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

class AddBierverkostung extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddBierverkostung(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addVerkostung() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Center(
      child: ElevatedButton(
        onPressed: addVerkostung,
        child: Text(
          "Add User",
        ),
      ),
    );
  }
}

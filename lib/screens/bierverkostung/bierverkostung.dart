// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Bierverkostung extends StatelessWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bierverkostung'),
    );
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
        builder: (BuildContext context) => const BierverkostungAlert(),
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

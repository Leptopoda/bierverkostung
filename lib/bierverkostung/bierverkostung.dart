// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Bierverkostung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Bierverkostung')),
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

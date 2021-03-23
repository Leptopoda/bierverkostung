// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class Statistiken extends StatefulWidget {
  @override
  State<Statistiken> createState() => _StatistikenState();
}

class _StatistikenState extends State<Statistiken> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Statistiken')),
    );
  }
}

class StatistikenFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
          context: context,
          builder: (_) => new StatistikenAlert(),
      ),
      child: Icon(Icons.add),
    );
  }
}

enum SingingCharacter { klein, gross }

class StatistikenAlert extends StatefulWidget {
  @override
  State<StatistikenAlert> createState() => _StatistikenAlertState();
}

class _StatistikenAlertState extends State<StatistikenAlert> {
  SingingCharacter? _character = SingingCharacter.gross;
  static int _menge = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Noch ein Bier"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RadioListTile<SingingCharacter>(
              title: const Text('Klein (0.3)'),
              value: SingingCharacter.klein,
              groupValue: _character,
              //TODO: use tehme
              activeColor: Colors.yellow,
              onChanged: (SingingCharacter? value) =>
                  setState(() => _character = value),
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Groß (0.5)'),
              value: SingingCharacter.gross,
              groupValue: _character,
              activeColor: Colors.yellow,
              onChanged: (SingingCharacter? value) =>
                  setState(() => _character = value),
            ),
            Slider(
              value: _menge.toDouble(),
              min: 1,
              max: 5,
              onChanged: (double value) {
                setState(() => _menge = value.round());
              },
              divisions: 4,
              label: "$_menge",
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: Text('Submit'),
            onPressed: () {
              print('$_menge $_character');
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

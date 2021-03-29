// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/services/database.dart';

import 'package:bierverkostung/shared/error_page.dart';

class Statistiken extends StatefulWidget {
  const Statistiken({Key? key}) : super(key: key);

  @override
  State<Statistiken> createState() => _StatistikenState();
}

class _StatistikenState extends State<Statistiken> {
  List<Map> _consumed = [];

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _consumed.length * 2,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          return _buildRow(_consumed[index].toString());
        });
  }

  void update() {
    SQLiteDbProvider.db
        .getAllKonsum()
        .then((value) => setState(() => _consumed = value));
  }

  Widget _buildRow(String consum) {
    return ListTile(
      title: Text(
        consum,
        style: _biggerFont,
      ),
    );
  }
}

class StatistikenFab extends StatelessWidget {
  const StatistikenFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => const StatistikenAlert(),
      ),
      child: const Icon(Icons.add),
    );
  }
}

enum _bier { klein, gross }
const _biggerFont = TextStyle(fontSize: 18.0);

class StatistikenAlert extends StatefulWidget {
  const StatistikenAlert({Key? key}) : super(key: key);

  @override
  State<StatistikenAlert> createState() => _StatistikenAlertState();
}

class _StatistikenAlertState extends State<StatistikenAlert> {
  _bier? _character = _bier.gross;
  static int _menge = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Noch ein Bier"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RadioListTile<_bier>(
              title: const Text('Klein (0.3)'),
              value: _bier.klein,
              groupValue: _character,
              //TODO: use tehme
              activeColor: Colors.yellow,
              onChanged: (_bier? value) => setState(() => _character = value),
            ),
            RadioListTile<_bier>(
              title: const Text('Groß (0.5)'),
              value: _bier.gross,
              groupValue: _character,
              activeColor: Colors.yellow,
              onChanged: (_bier? value) => setState(() => _character = value),
            ),
            Slider(
              value: _menge.toDouble(),
              min: 1,
              max: 5,
              onChanged: (double value) =>
                  setState(() => _menge = value.round()),
              divisions: 4,
              label: "$_menge",
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            switch (_character) {
              case _bier.klein:
                for (var i = 0; i < _menge; i++) {
                  SQLiteDbProvider.db.insertKonsum(0.33);
                }
                break;
              case _bier.gross:
                for (var i = 0; i < _menge; i++) {
                  SQLiteDbProvider.db.insertKonsum(0.5);
                }
                break;
              default:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SomethingWentWrong(
                            error: 'invalid response',
                          )),
                );
            }
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

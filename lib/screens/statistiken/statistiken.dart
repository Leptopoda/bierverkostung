// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    /* SQLiteDbProvider.db
        .getAllKonsum()
        .then((value) => setState(() => _consumed = value));
        */
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Leptopoda').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              print('hallo ${doc.data()}');
              return Card(
                child: ListTile(
                  title: Text(doc.data().toString()),
                ),
              );
            }).toList(),
          );
        }
      },
    );
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
          onPressed: () async {
            final DateTime date = DateTime.now();
            switch (_character) {
              case _bier.klein:
                for (var i = 0; i < _menge; i++) {
                  // SQLiteDbProvider.db.insertKonsum(0.33);
                  await DatabaseService(uid: 'Leptopoda')
                      .updateUserData(date, 0.33);
                }
                break;
              case _bier.gross:
                for (var i = 0; i < _menge; i++) {
                  // SQLiteDbProvider.db.insertKonsum(0.5);
                  await DatabaseService(uid: 'Leptopoda')
                      .updateUserData(date, 0.50);
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

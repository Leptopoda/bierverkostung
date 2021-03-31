// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/stats.dart';

class Statistiken extends StatefulWidget {
  const Statistiken({Key? key}) : super(key: key);

  @override
  State<Statistiken> createState() => _StatistikenState();
}

class _StatistikenState extends State<Statistiken> {
  @override
  Widget build(BuildContext context) {
    if (AuthService().getCurrentUid() == null) {
      return const Center(child: Text('Melde dich erst mal an du Affe'));
    }
    return StreamBuilder<List<Stat>>(
      stream: DatabaseService(uid: AuthService().getCurrentUid()!).stats,
      builder: (BuildContext context, AsyncSnapshot<List<Stat>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (!snapshot.hasData) {
              return const Center(
                  child: Text('noch keine Verkostungen vorhanden'));
            }

            return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: const EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        'Menge: ${snapshot.data![index].menge.toString()} Datum: ${snapshot.data![index].timestamp.toString()}',
                        style: const TextStyle(fontSize: 18)),
                  );
                });
        }
      },
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
        builder: (BuildContext context) => const StatistikenAlert(),
      ),
      child: const Icon(Icons.add),
    );
  }
}

enum _bier { klein, gross }
// const _biggerFont = TextStyle(fontSize: 18.0);

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
              onChanged: (_bier? value) => setState(() => _character = value),
            ),
            RadioListTile<_bier>(
              title: const Text('Groß (0.5)'),
              value: _bier.gross,
              groupValue: _character,
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
            if (AuthService().getCurrentUid() == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SomethingWentWrong(
                            error: 'Melde dich erstmal an du Affe',
                          )));
            } else {
              final DateTime date = DateTime.now();
              switch (_character) {
                case _bier.klein:
                  for (var i = 0; i < _menge; i++) {
                    await DatabaseService(uid: AuthService().getCurrentUid()!)
                        .saveStat(Stat(menge: 0.33, timestamp: date));
                  }
                  break;
                case _bier.gross:
                  for (var i = 0; i < _menge; i++) {
                    await DatabaseService(uid: AuthService().getCurrentUid()!)
                        .saveStat(Stat(menge: 0.5, timestamp: date));
                  }
                  break;
                default:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SomethingWentWrong(
                              error: 'invalid response',
                            )),
                  );
              }
            }
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

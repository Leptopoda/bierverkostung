// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/beers.dart';

class Statistiken extends StatelessWidget {
  const Statistiken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData _user = Provider.of<UserData?>(context)!;
    return StreamBuilder<List<Stat>>(
      stream: DatabaseService(user: _user).stats,
      builder: (BuildContext context, AsyncSnapshot<List<Stat>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return const Center(
                child: Text('noch keine Verkostungen vorhanden'),
              );
            }

            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    'Menge: ${snapshot.data![index].menge} '
                    'Datum: ${snapshot.data![index].timestamp} '
                    'Beer: ${snapshot.data![index].beer?.beerName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            );
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
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const StatistikenAlert(),
        );
      },
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
  final TextEditingController _beer = TextEditingController();

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
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              readOnly: true,
              controller: _beer,
              onTap: () => _selectBeer(context),
              decoration: const InputDecoration(
                labelText: 'Bier',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pflichtfeld';
                }
                return null;
              },
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
            final Beer? _bier1 = (_beer.value.text != '')
                ? Beer(
                    beerName: _beer.value.text,
                  )
                : null;
            final UserData _user = Provider.of<UserData?>(context)!;

            switch (_character) {
              case _bier.klein:
                for (int i = 0; i < _menge; i++) {
                  await DatabaseService(user: _user).saveStat(
                    Stat(menge: 0.33, timestamp: date, beer: _bier1),
                  );
                }
                break;
              case _bier.gross:
                for (int i = 0; i < _menge; i++) {
                  await DatabaseService(user: _user).saveStat(
                    Stat(menge: 0.5, timestamp: date, beer: _bier1),
                  );
                }
                break;
              default:
                Navigator.pushNamed(context, '/error',
                    arguments: 'invalid response');
            }

            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Future<void> _selectBeer(BuildContext context) async {
    final Beer? _beer1 = await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_beer1 != null) {
      setState(() {
        _beer.text = _beer1.beerName;
      });
    }
  }
}

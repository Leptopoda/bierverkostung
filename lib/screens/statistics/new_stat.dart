// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/stats.dart';
import 'package:bierverkostung/models/beers.dart';

/// Add Stat Button
class StatisticsFab extends StatelessWidget {
  const StatisticsFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const _StatisticsAlert(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

enum _Beer { small, big }
// const _biggerFont = TextStyle(fontSize: 18.0);

/// New Stats Alert
///
/// Let's the user input a new stat
class _StatisticsAlert extends StatefulWidget {
  const _StatisticsAlert({Key? key}) : super(key: key);

  @override
  State<_StatisticsAlert> createState() => _StatisticsAlertState();
}

class _StatisticsAlertState extends State<_StatisticsAlert> {
  _Beer? _character = _Beer.big;
  static int _menge = 1;
  final TextEditingController _beer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.stats_anotherBeer),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RadioListTile<_Beer>(
              title: Text(AppLocalizations.of(context)!.stats_smallBeer),
              value: _Beer.small,
              groupValue: _character,
              onChanged: (_Beer? value) => setState(() => _character = value),
            ),
            RadioListTile<_Beer>(
              title: Text(AppLocalizations.of(context)!.stats_bigBeer),
              value: _Beer.big,
              groupValue: _character,
              onChanged: (_Beer? value) => setState(() => _character = value),
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
              style: Theme.of(context).textTheme.bodyText2,
              readOnly: true,
              controller: _beer,
              onTap: () => _selectBeer(context),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beerOne,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.form_required;
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
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => _onSubmit(),
          child: Text(AppLocalizations.of(context)!.form_submit),
        ),
      ],
    );
  }

  /// validates the input and saves it to FireStore
  Future<void> _onSubmit() async {
    final DateTime date = DateTime.now();
    final Beer? _beer1 = (_beer.value.text != '')
        ? Beer(
            beerName: _beer.value.text,
          )
        : null;

    switch (_character) {
      case _Beer.small:
        for (int i = 0; i < _menge; i++) {
          await DatabaseService.saveStat(
            Stat(amount: 0.33, timestamp: date, beer: _beer1),
          );
        }
        break;
      case _Beer.big:
        for (int i = 0; i < _menge; i++) {
          await DatabaseService.saveStat(
            Stat(amount: 0.5, timestamp: date, beer: _beer1),
          );
        }
        break;
      default:
        Navigator.pushNamed(context, '/error', arguments: 'invalid response');
    }

    Navigator.of(context).pop();
  }

  /// selects a new [Beer] from the [BeerList]
  Future<void> _selectBeer(BuildContext context) async {
    final Beer? _beer1 = await Navigator.pushNamed<Beer?>(context, '/BeerList');

    if (_beer1 != null) {
      setState(() {
        _beer.text = _beer1.beerName;
      });
    }
  }
}

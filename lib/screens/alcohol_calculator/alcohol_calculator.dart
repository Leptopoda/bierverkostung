// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:bierverkostung/services/local_storage.dart';

part 'package:bierverkostung/shared/drink_safe.dart';

/// Button opening the screen for the [AlcoholCalculator]
@Deprecated('we directly implemented it into the [Home] screen')
class AlcoholCalculatorButton extends StatelessWidget {
  const AlcoholCalculatorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // TODO: chane icon
      icon: const Icon(Icons.no_drinks_outlined),
      tooltip: AppLocalizations.of(context)!.alcoholCalculator,
      onPressed: () {
        Navigator.pushNamed(context, '/AlcoholCalculator');
      },
    );
  }
}

/// Blod alcohol calculator
///
/// Formular is provided by https://promilleberechnen.de/promille-berechnen-formel/
class AlcoholCalculator extends StatefulWidget {
  const AlcoholCalculator({Key? key}) : super(key: key);

  @override
  _AlcoholCalculatorState createState() => _AlcoholCalculatorState();
}

enum _Gender { male, female }

class _AlcoholCalculatorState extends State<AlcoholCalculator> {
  _Gender? character = _Gender.male;
  int _age = 18;
  int _mass = 70;
  int _height = 175;
  int _stomachFill = 10;
  int _amountDrink = 500;
  double _alcohol = 0.049;
  int _time = 1;

  @override
  Future<void> didChangeDependencies() async {
    final bool? drinkResponsibleShown =
        await LocalDatabaseService.getDrinkSafe();
    if (drinkResponsibleShown == true) {
      return;
    }
    await showDialog(
      context: context,
      builder: (BuildContext _) => const _DrinkSafeAlert(),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.alcoholCalculator),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        // reverse: true,
        children: <Widget>[
          RadioListTile<_Gender>(
            title: Text(AppLocalizations.of(context)!.alcoholCalculator_female),
            value: _Gender.female,
            groupValue: character,
            onChanged: (_Gender? value) {
              setState(() {
                character = value;
              });
            },
          ),
          RadioListTile<_Gender>(
            title: Text(AppLocalizations.of(context)!.alcoholCalculator_male),
            value: _Gender.male,
            groupValue: character,
            onChanged: (_Gender? value) {
              setState(() {
                character = value;
              });
            },
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_age),
          Slider(
            value: _age.toDouble(),
            // min: 0,
            max: 100,
            onChanged: (double value) => setState(() => _age = value.round()),
            divisions: 100,
            label: _age.toString(),
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_weight),
          Slider(
            value: _mass.toDouble(),
            min: 10,
            max: 150,
            onChanged: (double value) => setState(() => _mass = value.round()),
            divisions: 140,
            label: _mass.toString(),
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_height),
          Slider(
            value: _height.toDouble(),
            min: 120,
            max: 220,
            onChanged: (double value) =>
                setState(() => _height = value.round()),
            divisions: 100,
            label: _height.toString(),
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_stomach),
          Slider(
            value: _stomachFill.toDouble(),
            // min: 0,
            max: 100,
            onChanged: (double value) =>
                setState(() => _stomachFill = value.round()),
            divisions: 10,
            label: '$_stomachFill',
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_drinkAmount),
          Slider(
            value: _amountDrink.toDouble(),
            // min: 0.0,
            max: 1000,
            onChanged: (double value) =>
                setState(() => _amountDrink = value.round()),
            divisions: 100,
            label: _amountDrink.toString(),
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_alcohol),
          Slider(
            value: _alcohol,
            // min: 0.0,
            max: 0.1,
            onChanged: (double value) => setState(() => _alcohol = value),
            divisions: 100,
            label: NumberFormat('#0.0#%').format(_alcohol),
          ),
          Text(AppLocalizations.of(context)!.alcoholCalculator_time),
          Slider(
            value: _time.toDouble(),
            // min: 0.0,
            max: 72,
            onChanged: (double value) => setState(() => _time = value.round()),
            divisions: 72,
            label: _time.toString(),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).disabledColor),
              ),
            ),
            child: Text(
              NumberFormat().format(_calculate()),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  /// Calculates the blood alcohol
  double _calculate() {
    final double _alcAmount = (_amountDrink * _alcohol) / 1.25;
    final double _redFaktor = (character == _Gender.male)
        ? (1.055 *
                (2.447 - 0.09516 * _age + 0.1074 * _height + 0.3362 * _mass)) /
            (0.8 * _mass)
        : (1.055 * (-2.097 + 0.1069 * _height + 0.2466 * _mass)) /
            (0.8 * _mass);

    double _theoAlc = _alcAmount / (_mass * _redFaktor);
    _theoAlc = _theoAlc - (_theoAlc * (0.2 * _stomachFill + 10)) / 100;
    final double _alc = _theoAlc - _time * 0.1;

    return _alc;
  }
}

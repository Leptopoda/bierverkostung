// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

//credits https://promilleberechnen.de/promille-berechnen-formel/

import 'package:flutter/material.dart';

import 'package:bierverkostung/shared/drink_safe.dart';

class PromilleRechnerButton extends StatelessWidget {
  const PromilleRechnerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // TODO: chane icon
      icon: const Icon(Icons.no_drinks_outlined),
      tooltip: 'Promille Rechner',
      onPressed: () {
        Navigator.pushNamed(context, '/PromilleRechner');
      },
    );
  }
}

class PromilleRechner extends StatefulWidget {
  const PromilleRechner({Key? key}) : super(key: key);

  @override
  _PromilleRechnerState createState() => _PromilleRechnerState();
}

enum Gender { male, female }

class _PromilleRechnerState extends State<PromilleRechner> {
  Gender? character = Gender.male;
  int age = 18;
  int gewicht = 70;
  int groesse = 175;
  int magenFuelle = 10;
  int mengeDrink = 500;
  double alcohol = 4.9;
  int time = 1;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await drinkSafe(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promille Rechner'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        // reverse: true,
        children: <Widget>[
          RadioListTile<Gender>(
            title: const Text('Female'),
            value: Gender.female,
            groupValue: character,
            onChanged: (Gender? value) {
              setState(() {
                character = value;
              });
            },
          ),
          RadioListTile<Gender>(
            title: const Text('Male'),
            value: Gender.male,
            groupValue: character,
            onChanged: (Gender? value) {
              setState(() {
                character = value;
              });
            },
          ),
          const Text('Age'),
          Slider(
            value: age.toDouble(),
            // min: 0,
            max: 100,
            onChanged: (double value) => setState(() => age = value.round()),
            divisions: 100,
            label: "$age",
          ),
          const Text('Gewicht'),
          Slider(
            value: gewicht.toDouble(),
            min: 10,
            max: 150,
            onChanged: (double value) =>
                setState(() => gewicht = value.round()),
            divisions: 140,
            label: "$gewicht",
          ),
          const Text('Größe'),
          Slider(
            value: groesse.toDouble(),
            min: 120,
            max: 220,
            onChanged: (double value) =>
                setState(() => groesse = value.round()),
            divisions: 100,
            label: "$groesse",
          ),
          const Text('Magen Fülle'),
          Slider(
            value: magenFuelle.toDouble(),
            // min: 0,
            max: 100,
            onChanged: (double value) =>
                setState(() => magenFuelle = value.round()),
            divisions: 10,
            label: "$magenFuelle",
          ),
          const Text('Getränk in ML'),
          Slider(
            value: mengeDrink.toDouble(),
            // min: 0.0,
            max: 1000,
            onChanged: (double value) =>
                setState(() => mengeDrink = value.round()),
            divisions: 100,
            label: "$mengeDrink",
          ),
          const Text('ALKOHOOOOL %'),
          Slider(
            value: alcohol,
            // min: 0.0,
            max: 10,
            onChanged: (double value) => setState(() => alcohol = value),
            divisions: 100,
            label: "$alcohol",
          ),
          const Text('Zeit'),
          Slider(
            value: time.toDouble(),
            // min: 0.0,
            max: 72,
            onChanged: (double value) => setState(() => time = value.round()),
            divisions: 72,
            label: "$time",
          ),
          Container(
            // color: Colors.orange[200],
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).disabledColor),
              ),
            ),
            child: Text(
              _calculate().toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  double _calculate() {
    final double _alcAmount = (mengeDrink * alcohol) / 125;
    final double _redFaktor = (character == Gender.male)
        ? (1.055 *
                (2.447 - 0.09516 * age + 0.1074 * groesse + 0.3362 * gewicht)) /
            (0.8 * gewicht)
        : (1.055 * (-2.097 + 0.1069 * groesse + 0.2466 * gewicht)) /
            (0.8 * gewicht);

    double _theoAlc = _alcAmount / (gewicht * _redFaktor);
    _theoAlc = _theoAlc - (_theoAlc * (0.2 * magenFuelle + 10)) / 100;
    final double _alc = _theoAlc - time * 0.1;

    return _alc;
  }
}

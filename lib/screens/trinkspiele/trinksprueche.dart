// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Trinksprueche extends StatefulWidget {
  final List<String> sprueche;

  const Trinksprueche({Key? key, required this.sprueche}) : super(key: key);

  @override
  State<Trinksprueche> createState() => _TrinkspruecheState();
}

class _TrinkspruecheState extends State<Trinksprueche> {
  static int _index = 1;

  void _randomIndex() {
    setState(() {
      _index = Random().nextInt(widget.sprueche.length) + 1;
    });
  }

  void _lastIndex() {
    if (_index > 1) {
      setState(() {
        _index--;
      });
    }
  }

  void _nextIndex() {
    if (_index < widget.sprueche.length) {
      setState(() {
        _index++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _randomIndex();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30.0),
      reverse: true,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _randomIndex(),
          child:
              Text(AppLocalizations.of(context)!.drinkingGames_toasts_random),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
              AppLocalizations.of(context)!.drinkingGames_toasts_random_desc),
        ),
        const SizedBox(height: 16),
        Slider(
          value: _index.toDouble(),
          min: 1,
          max: widget.sprueche.length.toDouble(),
          onChanged: (double value) => setState(() => _index = value.round()),
          divisions: widget.sprueche.length - 1,
          label: "$_index",
        ),
        const SizedBox(height: 16),
        Center(
          child:
              Text(AppLocalizations.of(context)!.drinkingGames_toasts_specific),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _lastIndex(),
              child:
                  Text(AppLocalizations.of(context)!.drinkingGames_toasts_back),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => _nextIndex(),
              child:
                  Text(AppLocalizations.of(context)!.drinkingGames_toasts_next),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          widget.sprueche[_index - 1],
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

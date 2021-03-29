// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_alt.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_neu.dart';

class Trinkspiele extends StatelessWidget {
  static const _spiele = ['Alte Trinksprüche', 'Neue Trinksprüche'];
  static final _spielePages = [
    const TrinkspruecheAlt(),
    const TrinkspruecheNeu()
  ];

  const Trinkspiele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: List.generate(_spiele.length * 2, (i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        return ListTile(
          leading: const Icon(Icons.message),
          title: Text(_spiele[index], style: const TextStyle(fontSize: 18)),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _spielePages[index]),
            );
          },
        );
      }),
    );
  }
}

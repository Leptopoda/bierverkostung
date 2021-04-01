// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_alt.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_neu.dart';

class Trinkspiele extends StatelessWidget {
  static const _spiele = [
    'Alte Trinksprüche',
    'Neue Trinksprüche',
  ];
  static final _spielePages = [
    const TrinkspruecheAlt(),
    const TrinkspruecheNeu(),
  ];

  const Trinkspiele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _spiele.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.message_outlined),
          title: Text(
            _spiele[index],
            style: const TextStyle(fontSize: 18),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => _spielePages[index],
            ),
          ),
        );
      },
    );
  }
}

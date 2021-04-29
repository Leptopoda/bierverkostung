// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/shared/home_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';

class Trinkspiele extends StatelessWidget {
  static const List<String> _spiele = [
    'Alte Trinksprüche',
    'Neue Trinksprüche',
  ];
  static const List<String> _spielePages = [
    '/Trinkspiele/TrinkspruecheAlt',
    '/Trinkspiele/TrinkspruecheNeu'
  ];

  const Trinkspiele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trinkspiele'),
        actions: const <Widget>[
          MeetingButton(),
          PromilleRechnerButton(),
          SettingsButton(),
        ],
      ),
      body: ListView.separated(
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
            onTap: () => Navigator.pushNamed(context, _spielePages[index]),
          );
        },
      ),
    );
  }
}

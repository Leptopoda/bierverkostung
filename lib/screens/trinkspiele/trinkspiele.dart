// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/screens/trinkspiele/trinksprueche_alt.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_neu.dart';
import 'package:bierverkostung/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:bierverkostung/shared/master_details_scaffold.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';

class Trinkspiele extends StatefulWidget {
  const Trinkspiele({Key? key}) : super(key: key);

  @override
  _TrinkspieleState createState() => _TrinkspieleState();
}

class _TrinkspieleState extends State<Trinkspiele> {
  static const List<String> _spiele = [
    'Alte Trinksprüche',
    'Neue Trinksprüche',
  ];
  static const List<Widget> _spielePages = [
    TrinkspruecheAlt(),
    TrinkspruecheNeu(),
  ];

  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return MasterDetailContainer(
      master: ListView.separated(
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
            onTap: () => _onTap(context, index),
          );
        },
      ),
      detail: _child,
      appBar: AppBar(
        title: const Text('Trinkspiele'),
        actions: const <Widget>[
          MeetingButton(),
          PromilleRechnerButton(),
          SettingsButton(),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => _spielePages[index],
        ),
      );
    } else {
      setState(() {
        _child = _spielePages[index];
      });
    }
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/statistiken/statistiken_list.dart';

import 'package:bierverkostung/screens/statistiken/new_statistiken.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';

class Statistiken extends StatelessWidget {
  const Statistiken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik'),
        actions: const <Widget>[
          MeetingButton(),
          PromilleRechnerButton(),
          SettingsButton(),
        ],
      ),
      body: const StatistikenList(),
      floatingActionButton: const StatistikenFab(),
    );
  }
}

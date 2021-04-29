// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  const HomeAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const <Widget>[
        MeetingButton(),
        PromilleRechnerButton(),
        SettingsButton(),
      ],
    );
  }
}

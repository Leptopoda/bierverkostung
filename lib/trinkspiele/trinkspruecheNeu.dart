// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/trinkspiele/trinksprueche/trinksprueche.dart';

class TrinkspruecheNeu extends StatelessWidget {
  final List<String> _sprueche = [
    'Nicht so schnell, da kommt noch was',
    'bleib geduldig',
    'wirklich sooo nüchtern',
  ];

  @override
  Widget build(BuildContext context) {
    return Trinksprueche(
      sprueche: _sprueche,
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/statistiken/statistiken_list.dart';
import 'package:bierverkostung/screens/statistiken/new_statistiken.dart';

/// Stats Screen
///
/// Screen containing the [Stats]
class Statistiken extends StatelessWidget {
  const Statistiken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatistikenList(),
      floatingActionButton: StatistikenFab(),
    );
  }
}

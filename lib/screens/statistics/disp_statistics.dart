// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/statistics/stst_list.dart';
import 'package:bierverkostung/screens/statistics/new_stat.dart';

/// Stats Screen
///
/// Screen containing the [Stat]
class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatisticsList(),
      floatingActionButton: StatisticsFab(),
    );
  }
}

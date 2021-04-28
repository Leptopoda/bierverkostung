// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';

import 'package:bierverkostung/screens/statistiken/beer_starts.dart';

class StatistikenList extends StatelessWidget {
  const StatistikenList({Key? key}) : super(key: key);

  /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final UserData _user = Provider.of<UserData?>(context)!;
  } */

  @override
  Widget build(BuildContext context) {
    final UserData _user = Provider.of<UserData?>(context)!;
    return StreamBuilder<List<Map>>(
      stream: DatabaseService(user: _user).statsComputed,
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('noch keine Verkostungen vorhanden'),
          );
        }
        return StatistikenBeerChart(data: snapshot.data!);
      },
    );
  }
}

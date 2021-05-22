// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

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
    return StreamBuilder<List<Map>>(
      stream: DatabaseService().statsComputed,
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return const Center(
                child: Text('noch keine Verkostungen vorhanden'),
              );
            }
            return StatistikenBeerChart(data: snapshot.data!);
          /*ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            StatistikenBeerChart(data: snapshot.data!),
            const Divider(),

          ],
        );*/
        }
      },
    );
  }
}

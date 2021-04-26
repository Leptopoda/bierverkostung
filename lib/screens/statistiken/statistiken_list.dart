// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/models/users.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/stats.dart';

class StatistikenList extends StatelessWidget {
  const StatistikenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData _user = Provider.of<UserData?>(context)!;
    return StreamBuilder<List<Stat>>(
      stream: DatabaseService(user: _user).stats,
      builder: (BuildContext context, AsyncSnapshot<List<Stat>> snapshot) {
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

            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    'Menge: ${snapshot.data![index].menge} '
                    'Datum: ${snapshot.data![index].timestamp} '
                    'Beer: ${snapshot.data![index].beer?.beerName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            );
        }
      },
    );
  }
}

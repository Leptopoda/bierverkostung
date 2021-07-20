// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';
import 'package:provider/provider.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';

part 'package:bierverkostung/screens/statistics/beer_stats.dart';
part 'package:bierverkostung/screens/statistics/graph_legend_item.dart';
part 'package:bierverkostung/screens/statistics/pie_chart_notifier.dart';

/// Stats List
///
/// Displays every [Stat] metric we currently expose to the user
class StatisticsList extends StatelessWidget {
  const StatisticsList({Key? key}) : super(key: key);

  /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final UserData _user = Provider.of<UserData?>(context)!;
  } */

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map>>(
      stream: DatabaseService.statsComputed,
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
              return Center(
                child: Text(AppLocalizations.of(context).stats_noStats),
              );
            }
            return _StatisticsBeerChart(data: snapshot.data!);
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

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/screens/beertasting/tasting.dart';
import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

/// Bieertasting widget
///
/// Scaffold regarding the Beertasting logic
class BeerTasting extends StatelessWidget {
  const BeerTasting({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tasting>>(
      stream: DatabaseService.tastings,
      builder: (BuildContext context, AsyncSnapshot<List<Tasting>> snapshot) {
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
                child: Text(AppLocalizations.of(context).beertasting_noTasting),
              );
            }

            return ResponsiveListScaffold.builder(
              scaffoldKey: _scaffoldKey,
              detailBuilder: (BuildContext context, int? index, bool tablet) {
                return DetailsScreen(
                  body: _BeerTastingDetail(
                    items: snapshot.data!,
                    row: index,
                    tablet: tablet,
                  ),
                );
              },
              nullItems: ResponsiveScaffoldNullItems(),
              emptyItems: ResponsiveScaffoldEmptyItems(),
              tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      'Bier: ${snapshot.data![index].beer.beerName} Datum: ${snapshot.data![index].date}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/NewTasting'),
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}

/// Detail screen of [Beertasting]
class _BeerTastingDetail extends StatelessWidget {
  const _BeerTastingDetail({
    Key? key,
    required this.items,
    required this.row,
    required this.tablet,
  }) : super(key: key);

  final List<Tasting> items;
  final int? row;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    return NewTasting(
      tasting: items[row!],
      // tablet: tablet,
    );
  }
}

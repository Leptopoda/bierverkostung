// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

/// Beer list Widget
///
/// Displays a list with every [Beer]
class BeerList extends StatelessWidget {
  const BeerList({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Beer>>(
      stream: DatabaseService.beers,
      builder: (BuildContext context, AsyncSnapshot<List<Beer>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: snapshot.error.toString(),
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
                child: Text(AppLocalizations.of(context).beer_noBeers),
              );
            }

            return ResponsiveListScaffold.builder(
              scaffoldKey: _scaffoldKey,
              detailBuilder: (BuildContext context, int? index, bool tablet) {
                return DetailsScreen(
                  body: _BeerListDetail(
                    items: snapshot.data!,
                    row: index,
                    tablet: tablet,
                  ),
                );
              },
              nullItems: ResponsiveScaffoldNullItems(),
              emptyItems: ResponsiveScaffoldEmptyItems(),
              tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).beerOther),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      'Bier: ${snapshot.data![index].beerName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    onTap: () {
                      Navigator.pop(context, snapshot.data![index]);
                    },
                  ),
                );
              },
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/NewBeer'),
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}

/// Displays a selected [Beer] out of [BeerList]
class _BeerListDetail extends StatelessWidget {
  const _BeerListDetail({
    Key? key,
    required this.items,
    required this.row,
    required this.tablet,
  }) : super(key: key);

  final List<Beer> items;
  final int? row;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !tablet,
        title: Text(AppLocalizations.of(context).beer_newBeer),
        // actions: tablet ? actionBarItems : null,
      ),
      body: Center(
        child: Text(items[row!].beerName),
      ),
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show QueryDocumentSnapshot, QuerySnapshot;

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

import 'package:bierverkostung/screens/beer/beer_data.dart';

/// Beer list Widget
///
/// Displays a list with every [Beer]
class BeerList extends StatelessWidget {
  const BeerList({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Beer>>(
      stream: DatabaseService.beers,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot<Beer>> snapshot) {
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

            final List<QueryDocumentSnapshot<Beer>> _data = snapshot.data!.docs;

            return ResponsiveListScaffold.builder(
              scaffoldKey: _scaffoldKey,
              detailBuilder: (BuildContext context, int index, bool tablet) {
                final QueryDocumentSnapshot<Beer> _beer = _data[index];
                return DetailsScreen(
                  body: BeerInfoList(
                    // selectable: true,
                    key: ValueKey<int>(index),
                    tablet: tablet,
                    beerDocument: _beer,
                  ),
                );
              },
              nullItems: ResponsiveScaffoldNullItems(),
              emptyItems: ResponsiveScaffoldEmptyItems(),
              tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).beerOther),
              ),
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                final Beer _beer = _data[index].data();
                return Card(
                  child: ListTile(
                    title: Text(
                      'Bier: ${_beer.beerName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              floatingActionButton: FloatingActionButton(
                heroTag: const ValueKey<String>('newBeerFabTag'),
                key: const ValueKey<String>('newBeerFab'),
                onPressed: () => Navigator.pushNamed(context, '/NewBeer'),
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}

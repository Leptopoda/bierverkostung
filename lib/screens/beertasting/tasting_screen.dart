// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show QueryDocumentSnapshot, QuerySnapshot;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';
import 'package:bierverkostung/models/tastings.dart';

import 'package:bierverkostung/screens/beertasting/tasting_data.dart';

/// Bieertasting widget
///
/// Scaffold regarding the Beertasting logic
class BeerTasting extends StatelessWidget {
  const BeerTasting({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Tasting>>(
      stream: DatabaseService.tastings,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Tasting>> snapshot) {
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

            final List<QueryDocumentSnapshot<Tasting>> _data =
                snapshot.data!.docs;

            return ResponsiveListScaffold.builder(
              scaffoldKey: BeerTasting._scaffoldKey,
              detailBuilder: (BuildContext context, int index, bool tablet) {
                final QueryDocumentSnapshot<Tasting> _tasting = _data[index];
                return DetailsScreen(
                  body: TastingInfoList(
                    tastingDocument: _tasting,
                    tablet: tablet,
                  ),
                );
              },
              nullItems: ResponsiveScaffoldNullItems(),
              emptyItems: ResponsiveScaffoldEmptyItems(),
              tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                final Tasting _tasting = _data[index].data();
                return Card(
                  child: ListTile(
                    title: Text(
                      'Bier: ${_tasting.beer.beerName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    subtitle: Text(
                      'Datum: ${_tasting.date}',
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

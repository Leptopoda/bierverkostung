// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/screens/beer/beer_data.dart';
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
              scaffoldKey: BeerTasting._scaffoldKey,
              detailBuilder: (BuildContext context, int? index, bool tablet) {
                return DetailsScreen(
                  body: TastingInfoList(
                    tasting: snapshot.data![index!],
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
                      'Bier: ${snapshot.data![index].beer.beerName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    subtitle: Text(
                      'Datum: ${snapshot.data![index].date}',
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
@Deprecated(
    'we only use [TastingInfoList] for now.. we might change that though to be able to also diyplay the beer data')
class _BeerTastingDetail extends StatefulWidget {
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
  _BeerTastingDetailState createState() => _BeerTastingDetailState();
}

// ignore: deprecated_member_use_from_same_package
class _BeerTastingDetailState extends State<_BeerTastingDetail> {
  bool onEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.tablet
          ? AppBar(
              title: Text(AppLocalizations.of(context).beertasting),
              actions: [
                IconButton(
                  tooltip: 'Edit Tasting',
                  onPressed: () {
                    setState(() => onEdit = true);
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TastingInfoList(
              tasting: widget.items[widget.row!],
              // onEdit: onEdit,
              // tablet: tablet,
            ),
            BeerInfoList(
              beer: widget.items[widget.row!].beer,
            ),
          ],
        ),
      ),
    );
  }
}

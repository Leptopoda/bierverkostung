// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _groupID;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    _groupID = await AuthService().getClaim('group_id') as String?;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Beer>>(
      stream: DatabaseService(groupID: _groupID).beers,
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
                child: Text(AppLocalizations.of(context)!.beer_noBeers),
              );
            }

            return ResponsiveListScaffold.builder(
              scaffoldKey: _scaffoldKey,
              detailBuilder: (BuildContext context, int? index, bool tablet) {
                return DetailsScreen(
                  body: BeerListDetail(
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
                title: Text(AppLocalizations.of(context)!.beerOther),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    'Bier: ${snapshot.data![index].beerName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context, snapshot.data![index]);
                  },
                );
              },
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).pushNamed('/NewBeer'),
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}

class BeerListDetail extends StatelessWidget {
  const BeerListDetail({
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
        title: Text(AppLocalizations.of(context)!.beer_newBeer),
        // actions: tablet ? actionBarItems : null,
      ),
      body: Center(
        child: Text(items[row!].beerName),
      ),
    );
  }
}

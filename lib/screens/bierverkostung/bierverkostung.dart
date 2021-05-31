// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

import 'package:bierverkostung/screens/bierverkostung/disp_verkostung.dart';

class Bierverkostung extends StatefulWidget {
  const Bierverkostung({Key? key}) : super(key: key);

  @override
  _BierverkostungState createState() => _BierverkostungState();
}

class _BierverkostungState extends State<Bierverkostung> {
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
    return StreamBuilder<List<Tasting>>(
      stream: DatabaseService(groupID: _groupID).tastings,
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
                child:
                    Text(AppLocalizations.of(context)!.beertasting_noTasting),
              );
            }

            return ResponsiveListScaffold.builder(
              scaffoldKey: _scaffoldKey,
              detailBuilder: (BuildContext context, int? index, bool tablet) {
                return DetailsScreen(
                  body: BierverkostungDetail(
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
                return ListTile(
                  title: Text(
                    'Bier: ${snapshot.data![index].beer.beerName} Datum: ${snapshot.data![index].date}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).pushNamed('/NewTasting'),
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}

class BierverkostungDetail extends StatelessWidget {
  const BierverkostungDetail({
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
    return DispTasting(
      tasting: items[row!],
      tablet: tablet,
    );
  }
}

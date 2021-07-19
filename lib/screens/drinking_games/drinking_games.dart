// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

import 'package:bierverkostung/screens/drinking_games/toasts_old.dart';
import 'package:bierverkostung/screens/drinking_games/toasts_new.dart';
import 'package:bierverkostung/screens/drinking_games/burning_ring_of_fire.dart';

/// Drinking Gmes
///
/// Displays a list of drinking games
class Trinkspiele extends StatelessWidget {
  const Trinkspiele({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<Widget> _spielePages = [
    ToastsOld(),
    ToastsNew(),
    BurningRingOfFire(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> _spiele = [
      AppLocalizations.of(context)!.drinkingGames_toasts_old,
      AppLocalizations.of(context)!.drinkingGames_toasts_new,
      AppLocalizations.of(context)!.drinkingGames_burningRingOfFire,
    ];
    return ResponsiveListScaffold.builder(
      scaffoldKey: _scaffoldKey,
      detailBuilder: (BuildContext context, int? index, bool tablet) {
        return DetailsScreen(
          body: _TrinkspieleDetail(
            items: _spielePages,
            row: index,
            tablet: tablet,
          ),
        );
      },
      nullItems: ResponsiveScaffoldNullItems(),
      emptyItems: ResponsiveScaffoldEmptyItems(),
      tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
      itemCount: _spiele.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.message_outlined),
          title: Text(
            _spiele[index],
            style: Theme.of(context).textTheme.bodyText2,
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        );
      },
    );
  }
}

/// Detail screen of [TrinkSpiele]
class _TrinkspieleDetail extends StatelessWidget {
  const _TrinkspieleDetail({
    Key? key,
    required this.items,
    required this.row,
    required this.tablet,
  }) : super(key: key);

  final List<Widget> items;
  final int? row;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !tablet
          ? AppBar(
              automaticallyImplyLeading: !tablet,
              title: Text(AppLocalizations.of(context)!.details),
            )
          : null,
      body: (row != null) ? items[row!] : null,
    );
  }
}

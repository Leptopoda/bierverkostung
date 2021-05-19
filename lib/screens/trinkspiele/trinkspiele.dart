// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/screens/trinkspiele/burning_ring_of_fire.dart';
import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_alt.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_neu.dart';
import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

class Trinkspiele extends StatefulWidget {
  const Trinkspiele({Key? key}) : super(key: key);

  @override
  _TrinkspieleState createState() => _TrinkspieleState();
}

class _TrinkspieleState extends State<Trinkspiele> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _spiele = [
    'Alte Trinksprüche',
    'Neue Trinksprüche',
    'Burning ring of fire',
  ];

  static const List<Widget> _spielePages = [
    TrinkspruecheAlt(),
    TrinkspruecheNeu(),
    BurningRingOfFire(),
  ];

  static const List<Widget> _actionBarItems = [
    MeetingButton(),
    PromilleRechnerButton(),
    SettingsButton(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveListScaffold.builder(
      scaffoldKey: _scaffoldKey,
      detailBuilder: (BuildContext context, int? index, bool tablet) {
        return DetailsScreen(
          body: TrinkspieleDetail(
            items: _spielePages,
            row: index,
            tablet: tablet,
            actionBarItems: _actionBarItems,
          ),
        );
      },
      nullItems: ResponsiveScaffoldNullItems(),
      emptyItems: ResponsiveScaffoldEmptyItems(),
      tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
      appBar: AppBar(
        title: const Text('Trinkspiele'),
        actions: _actionBarItems,
      ),
      itemCount: _spiele.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.message_outlined),
          title: Text(
            _spiele[index],
            style: const TextStyle(fontSize: 18),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        );
      },
    );
  }
}

class TrinkspieleDetail extends StatelessWidget {
  const TrinkspieleDetail({
    Key? key,
    required this.items,
    required this.row,
    required this.tablet,
    this.actionBarItems,
  }) : super(key: key);

  final List<Widget> items;
  final int? row;
  final bool tablet;
  final List<Widget>? actionBarItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !tablet,
        title: const Text('Details'),
        // actions: tablet ? actionBarItems : null,
      ),
      body: (row != null) ? items[row!] : null,
    );
  }
}

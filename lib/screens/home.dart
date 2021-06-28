// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:navigation_rail/navigation_rail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/local_storage.dart';
import 'package:bierverkostung/services/firebase/notifications.dart';

import 'package:bierverkostung/screens/beertasting/beertasting.dart';
import 'package:bierverkostung/screens/drinking_games/drinking_games.dart';
import 'package:bierverkostung/screens/statistics/disp_statistics.dart';

part 'package:bierverkostung/shared/drink_responsible.dart';

/// Home Screen
///
/// Contains the NavBar and sections for the App
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 1;
  late List<String> _pageTitles;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final bool? isFirstLogin = await LocalDatabaseService.getFirstLogin();
    if (isFirstLogin == false) {
      NotificationService.askPermission();
      LocalDatabaseService.setFirstLogin();
    }
    await NotificationService.initialise();

    _pageTitles = [
      AppLocalizations.of(context)!.drinkingGames,
      AppLocalizations.of(context)!.beertasting,
      AppLocalizations.of(context)!.stats,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NavRail(
      /* drawerHeaderBuilder: (context) {
        return Column(
          children: const <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Steve Jobs"),
              accountEmail: Text("jobs@apple.com"),
            ),
          ],
        );
      }, */
      drawerFooterBuilder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.money_outlined),
              title: Text(AppLocalizations.of(context)!.moneyCalculator),
              onTap: () => Navigator.pushNamed(context, '/MoneyCalculator'),
            ),
            ListTile(
              leading: const Icon(Icons.no_drinks_outlined),
              title: Text(AppLocalizations.of(context)!.alcoholCalculator),
              onTap: () => Navigator.pushNamed(context, '/PromilleRechner'),
            ),
            ListTile(
              leading: const Icon(Icons.call_outlined),
              title: Text(AppLocalizations.of(context)!.conference),
              onTap: () => Navigator.pushNamed(context, '/Conference'),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(AppLocalizations.of(context)!.settings),
              onTap: () => Navigator.pushNamed(context, '/Settings'),
            ),
            /* ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
            ), */
          ],
        );
      },
      title: Text(_pageTitles[_currentIndex]),
      currentIndex: _currentIndex,
      onTap: (val) async {
        if (mounted) setState(() => _currentIndex = val);

        if (_currentIndex == 0) {
          final bool? drinkResponsibleShown =
              await LocalDatabaseService.getDrinkResponsible();
          if (drinkResponsibleShown == true) {
            return;
          }
          await showDialog(
            context: context,
            builder: (BuildContext _) => const _DrinkResponsibleAlert(),
          );
        }
      },
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[
          Trinkspiele(),
          BeerTasting(),
          Statistics(),
        ],
      ),
      tabs: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.casino_outlined),
          label: _pageTitles[0],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: _pageTitles[1],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.show_chart),
          label: _pageTitles[2],
        ),
      ],
    );
  }
}

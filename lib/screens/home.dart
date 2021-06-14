// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:navigation_rail/navigation_rail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/local_storage.dart';
import 'package:bierverkostung/services/firebase/notifications.dart';
import 'package:bierverkostung/shared/drink_safe.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/statistiken/disp_statistiken.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 1;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final bool? isFirstLogin = await LocalDatabaseService().getFirstLogin();
    if (isFirstLogin == false) {
      NotificationService().askPermission();
      LocalDatabaseService().setFirstLogin();
    }
    await NotificationService().initialise();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _pageTitles = [
      AppLocalizations.of(context)!.drinkingGames,
      AppLocalizations.of(context)!.beertasting,
      AppLocalizations.of(context)!.stats,
    ];

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
          await drinkResponsible(context);
        }
      },
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[
          Trinkspiele(),
          Bierverkostung(),
          Statistiken(),
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

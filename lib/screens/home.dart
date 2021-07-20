// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigation_rail/navigation_rail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/local_storage.dart';
import 'package:bierverkostung/services/firebase/notifications.dart';
import 'package:bierverkostung/services/conference_service.dart';
import 'package:bierverkostung/services/firebase/auth.dart';

import 'package:bierverkostung/screens/beertasting/beertasting.dart';
import 'package:bierverkostung/screens/drinking_games/drinking_games.dart';
import 'package:bierverkostung/screens/statistics/disp_statistics.dart';

part 'package:bierverkostung/screens/welcome_screen/welcome_screen.dart';
part 'package:bierverkostung/shared/drink_responsible.dart';
part 'package:bierverkostung/shared/validate_email_unvalidated.dart';
part 'package:bierverkostung/shared/validate_email.dart';

/// Home Screen
///
/// Contains the NavBar and sections for the App
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  /// currently selected screen
  int _currentIndex = 1;

  /// Internationalized Titles for the shown screens
  late List<String> _pageTitles;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _WelcomeScreen.showWelcomeScreen(context);

    await NotificationService.initialise();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Changes to the next seen screen
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// Animates to the next selected screen.
  void _onItemSelected(int index) {
    _onPageChanged(index);
    _pageController.animateToPage(
      index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  /// checks wether to show the [_DrinkResponsibleAlert] and displays it when necessary
  Future<void> _showDrinkResponsible() async {
    final bool? drinkResponsibleShown =
        await LocalDatabaseService.getDrinkResponsible();
    if (drinkResponsibleShown == true) {
      return;
    }
    await showDialog(
      context: context,
      builder: (_) => const _DrinkResponsibleAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _pageTitles = [
      AppLocalizations.of(context).drinkingGames,
      AppLocalizations.of(context).beertasting,
      AppLocalizations.of(context).stats,
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
              title: Text(AppLocalizations.of(context).moneyCalculator),
              onTap: () => Navigator.pushNamed(context, '/MoneyCalculator'),
            ),
            ListTile(
              leading: const Icon(Icons.no_drinks_outlined),
              title: Text(AppLocalizations.of(context).alcoholCalculator),
              onTap: () => Navigator.pushNamed(context, '/PromilleRechner'),
            ),
            ListTile(
              leading: const Icon(Icons.call_outlined),
              title: Text(AppLocalizations.of(context).conference),
              onTap: () => ConferenceService.startMeeting(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(AppLocalizations.of(context).settings),
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
        if (mounted) _onItemSelected(val);
        if (_currentIndex == 0) await _showDrinkResponsible();
      },
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
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

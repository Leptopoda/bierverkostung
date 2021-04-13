// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';

import 'package:bierverkostung/screens/bierverkostung/beers.dart';
import 'package:bierverkostung/screens/bierverkostung/disp_verkostung.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/screens/home.dart';
import 'package:bierverkostung/screens/bierverkostung/new_tasting.dart';
import 'package:bierverkostung/screens/bierverkostung/new_beer.dart';
import 'package:bierverkostung/screens/settings/qr_scan.dart';
import 'package:bierverkostung/screens/settings/user_settings.dart';
import 'package:bierverkostung/screens/settings/group_management.dart';
import 'package:bierverkostung/screens/login.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_alt.dart';
import 'package:bierverkostung/screens/trinkspiele/trinksprueche_neu.dart';

// import 'package:bierverkostung/screens/settings.dart';
// import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
// import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
// import 'package:bierverkostung/screens/statistiken/statistiken.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final _args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHome());

      case '/NewTasting':
        return MaterialPageRoute(builder: (_) => const NewTasting());

      case '/DispTasting':
        if (_args is Tasting) {
          return MaterialPageRoute(
            builder: (_) => DispTasting(
              tasting: _args,
            ),
          );
        }
        return _errorRoute();

      case '/NewBeer':
        return MaterialPageRoute(builder: (_) => NewBeer());

      case '/BeerList':
        return MaterialPageRoute<Beer?>(builder: (_) => const BeerList());

      case '/Login':
        return MaterialPageRoute(builder: (_) => const Login());

      case '/Settings/Groups':
        return MaterialPageRoute(builder: (_) => const GroupScreen());

      case '/Settings/Groups/ScanCode':
        return MaterialPageRoute(builder: (_) => const QRViewExample());

      case '/Settings/User':
        return MaterialPageRoute(builder: (_) => const LogOutAlert());

      case '/Trinkspiele/TrinkspruecheAlt':
        return MaterialPageRoute(builder: (_) => const TrinkspruecheAlt());

      case '/Trinkspiele/TrinkspruecheNeu':
        return MaterialPageRoute(builder: (_) => const TrinkspruecheNeu());

      case '/error':
        if (_args is String) {
          return MaterialPageRoute(
              builder: (_) => SomethingWentWrong(error: _args));
        }
        return _errorRoute();

      case '/404':
        return MaterialPageRoute(
            builder: (_) =>
                const SomethingWentWrong(error: '404 Page not found'));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const SomethingWentWrong(
        error: 'this route does not exist',
      );
    });
  }
}

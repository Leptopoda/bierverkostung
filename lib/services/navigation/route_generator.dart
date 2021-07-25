// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/services/navigation/navigation.dart';

/// Handles the routes used for navigating the app
class RouteGenerator {
  const RouteGenerator._();

  /// generates the routes used for navigating the app
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final _args = settings.arguments;

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => const LoginController());

      case '/Home':
        return MaterialPageRoute(builder: (_) => const MyHome());

      case '/NewTasting':
        return MaterialPageRoute(builder: (_) => const TastingInfoList());

      /* case '/DispTasting':
        if (_args is Tasting) {
          return MaterialPageRoute(
            builder: (_) => DispTasting(
              tasting: _args,
            ),
          );
        }
        return _errorRoute(); */

      case '/NewBeer':
        return MaterialPageRoute(builder: (_) => const NewBeer());

      case '/BeerList':
        return MaterialPageRoute<Beer?>(builder: (_) => const BeerList());

      // case '/Conference':
      //   return MaterialPageRoute<Beer?>(builder: (_) => const Meeting());

      case '/Login':
        return MaterialPageRoute(builder: (_) => const Login());

      case '/Settings':
        return MaterialPageRoute(builder: (_) => const Settings());

      case '/Settings/Groups':
        return MaterialPageRoute(builder: (_) => const GroupScreen());

      // case '/Settings/Groups/ScanCode':
      //   return MaterialPageRoute(builder: (_) => const QRViewExample());

      case '/Settings/User':
        return MaterialPageRoute(builder: (_) => const UserSettings());

      /* case '/Settings/About':
        return MaterialPageRoute(builder: (_) => const AboutUsSettings()); */

      case '/Settings/Import':
        return MaterialPageRoute(builder: (_) => const ImportDataSettings());

      case '/Trinkspiele/TrinkspruecheAlt':
        return MaterialPageRoute(builder: (_) => const ToastsOld());

      case '/Trinkspiele/TrinkspruecheNeu':
        return MaterialPageRoute(builder: (_) => const ToastsNew());

      case '/PromilleRechner':
        return MaterialPageRoute(builder: (_) => const AlcoholCalculator());

      case '/MoneyCalculator':
        return MaterialPageRoute(builder: (_) => const MoneyCalculator());

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

  /// builds the error route
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const SomethingWentWrong(
        error: 'this route does not exist',
      );
    });
  }
}

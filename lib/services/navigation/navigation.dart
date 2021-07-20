// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/beers.dart';

import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/screens/beer/beers.dart';
// import 'package:bierverkostung/screens/bierverkostung/disp_verkostung.dart';
import 'package:bierverkostung/screens/home.dart';
import 'package:bierverkostung/screens/beertasting/new_tasting.dart';
import 'package:bierverkostung/screens/beer/new_beer.dart';
// import 'package:bierverkostung/screens/conference/conference.dart';
import 'package:bierverkostung/screens/settings/settings.dart';
import 'package:bierverkostung/screens/settings/user_settings/user_settings.dart';
import 'package:bierverkostung/screens/settings/group_settings/group_management.dart';
// import 'package:bierverkostung/screens/settings/about_us_settings.dart';
import 'package:bierverkostung/screens/settings/import_data_settings.dart';
import 'package:bierverkostung/screens/login/login.dart';
// import 'package:bierverkostung/screens/login_controller.dart';
import 'package:bierverkostung/screens/drinking_games/toasts_old.dart';
import 'package:bierverkostung/screens/drinking_games/toasts_new.dart';
import 'package:bierverkostung/screens/alcohol_calculator/alcohol_calculator.dart';
import 'package:bierverkostung/screens/money_management/money_management.dart';

part 'package:bierverkostung/services/navigation/route_generator.dart';

/// Navigation Service
///
/// handling the navigation of the app with a [GlobalKey<NavigatorState>]
class NavigationService {
  const NavigationService._();

  /// navigation key for navigating the app
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  /// getter for the navigation key
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // static Future<dynamic> navigateTo(String routeName) {
  //   return navigatorKey.currentState!.pushNamed(routeName);
  // }
}

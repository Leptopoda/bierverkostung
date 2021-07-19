// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/alcohol_calculator/alcohol_calculator.dart';

/// Drink safe Alert
///
/// Alerts the user to drink safe
class _DrinkSafeAlert extends StatelessWidget {
  const _DrinkSafeAlert({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.drinkSafe),
      // TODO: change message
      content: Text(AppLocalizations.of(context)!.drinkSafe_banner),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await LocalDatabaseService.setDrinkSafe();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.alert_donotShowAgain),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}

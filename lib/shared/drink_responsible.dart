// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/home.dart';

/// Drink Responsible Alert
///
/// Alerts the user to drink responsible
class _DrinkResponsibleAlert extends StatelessWidget {
  const _DrinkResponsibleAlert({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.drinkSafe),
      content: Text(AppLocalizations.of(context)!.drinkResponsible_banner),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await LocalDatabaseService.setDrinkResponsible();
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

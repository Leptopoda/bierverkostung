// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/services/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> drinkResponsible(BuildContext context) async {
  final bool? drinkResponsibleShown =
      await LocalDatabaseService().getDrinkResponsible();
  if (drinkResponsibleShown == true) {
    return;
  }
  return showDialog(
    context: context,
    builder: (BuildContext _) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.drinkSafe),
      content: SingleChildScrollView(
        child: Text(AppLocalizations.of(context)!.drinkResponsible_banner),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            LocalDatabaseService().setDrinkResponsible();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.alert_donotShowAgain),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    ),
  );
}

Future<void> drinkSafe(BuildContext context) async {
  final bool? drinkResponsibleShown =
      await LocalDatabaseService().getDrinkSafe();
  if (drinkResponsibleShown == true) {
    return;
  }
  return showDialog(
    context: context,
    builder: (BuildContext _) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.drinkSafe),
      // TODO: change message
      content: SingleChildScrollView(
        child: Text(AppLocalizations.of(context)!.drinkSafe_banner),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            LocalDatabaseService().setDrinkSafe();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.alert_donotShowAgain),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    ),
  );
}

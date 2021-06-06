// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/models/money_calc.dart';

class MoneyFab extends StatelessWidget {
  const MoneyFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const MoneyAlert(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class MoneyAlert extends StatefulWidget {
  const MoneyAlert({Key? key}) : super(key: key);

  @override
  State<MoneyAlert> createState() => _MoneyAlertState();
}

class _MoneyAlertState extends State<MoneyAlert> {
  final TextEditingController _buyer = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    _buyer.text = AuthService().getUser()!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.stats_anotherBeer),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              controller: _buyer,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.settings_groupManagement_uid,
              ),
              validator: (value) {
                if (value is! String) {
                  return 'not a Number';
                }
                return null;
              },
            ),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              controller: _amount,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.moneyCalculator_amount,
              ),
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value != null && !RegExp('(?=.*[A-Z])').hasMatch(value)) {
                  return 'not a number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => _onSubmit(),
          child: Text(AppLocalizations.of(context)!.form_submit),
        ),
      ],
    );
  }

  Future<void> _onSubmit() async {
    final DateTime _date = DateTime.now();

    await DatabaseService().saveMoneyCalc(
      MoneyCalc(
        buyer: _buyer.value.text,
        amount: double.parse(_amount.value.text) * -1,
        timestamp: _date,
        // participants: participants,
      ).toJson(),
    );

    Navigator.of(context).pop();
  }
}

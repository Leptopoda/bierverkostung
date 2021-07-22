// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bierverkostung/gen/colors.gen.dart';
import 'package:intl/intl.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/money_calc.dart';
import 'package:bierverkostung/models/group.dart';
import 'package:bierverkostung/models/user.dart';

part 'package:bierverkostung/screens/money_management/new_money.dart';
part 'package:bierverkostung/screens/money_management/user_profile_information.dart';

/// Group Money calculator
///
/// Enables groups to calculate their spendings
/// both individually and together
class MoneyCalculator extends StatelessWidget {
  const MoneyCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).moneyCalculator),
      ),
      body: Column(
        children: const <Widget>[
          SizedBox(
            height: 100,
            child: _CalculatedList(),
          ),
          Expanded(
            child: _MoneyList(),
          ),
        ],
      ),
      floatingActionButton: const _MoneyFab(),
    );
  }
}

/// List of users and their budget
class _CalculatedList extends StatelessWidget {
  const _CalculatedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MoneyCalc>>(
      stream: DatabaseService.moneyCalcComp,
      builder: (BuildContext context, AsyncSnapshot<List<MoneyCalc>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return Center(
                child:
                    Text(AppLocalizations.of(context).moneyCalculator_noData),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _MoneyCalcCard(moneyCalc: snapshot.data![index]);
              },
              itemExtent: 500,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
            );
        }
      },
    );
  }
}

/// List of Spendings
class _MoneyList extends StatelessWidget {
  const _MoneyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MoneyCalc>>(
      stream: DatabaseService.moneyCalc,
      builder: (BuildContext context, AsyncSnapshot<List<MoneyCalc>> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: '${snapshot.error}',
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData) {
              return Center(
                child:
                    Text(AppLocalizations.of(context).moneyCalculator_noData),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _MoneyCalcCard(moneyCalc: snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
            );
        }
      },
    );
  }
}

class _MoneyCalcCard extends StatelessWidget {
  final MoneyCalc moneyCalc;
  const _MoneyCalcCard({
    required this.moneyCalc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context).moneyCalculator_buyer,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            _UserProfileInformation(uid: moneyCalc.buyer),
          ],
        ),
        subtitle: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.subtitle2,
            children: <TextSpan>[
              TextSpan(
                text: AppLocalizations.of(context)
                    .moneyCalculator_date(moneyCalc.timestamp),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text:
                    '${AppLocalizations.of(context).moneyCalculator_amount}: ',
              ),
              TextSpan(
                text: NumberFormat('#0.0#').format(moneyCalc.amount),
                style: (moneyCalc.amount >= 0)
                    ? const TextStyle(color: ColorName.green)
                    : const TextStyle(color: ColorName.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/models/money_calc.dart';

part 'new_money.dart';

class MoneyCalculator extends StatelessWidget {
  const MoneyCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.moneyCalculator),
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

class _CalculatedList extends StatelessWidget {
  const _CalculatedList({
    Key? key,
  }) : super(key: key);

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
                    Text(AppLocalizations.of(context)!.moneyCalculator_noData),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      'Buyer: ${snapshot.data![index].buyer}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Date: ${snapshot.data![index].timestamp}\n'),
                          const TextSpan(
                            text: 'Amount: ',
                          ),
                          TextSpan(
                            text: NumberFormat('#0.0#')
                                .format(snapshot.data![index].amount),
                            style: (snapshot.data![index].amount >= 0)
                                ? const TextStyle(color: Colors.green)
                                : const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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

class _MoneyList extends StatelessWidget {
  const _MoneyList({
    Key? key,
  }) : super(key: key);

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
                    Text(AppLocalizations.of(context)!.moneyCalculator_noData),
              );
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      'Date: ${snapshot.data![index].timestamp}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Buyer: ${snapshot.data![index].buyer}\n'),
                          const TextSpan(
                            text: 'Amount: ',
                          ),
                          TextSpan(
                            text: NumberFormat('#0.0#')
                                .format(snapshot.data![index].amount),
                            style: (snapshot.data![index].amount >= 0)
                                ? const TextStyle(color: Colors.green)
                                : const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
        }
      },
    );
  }
}

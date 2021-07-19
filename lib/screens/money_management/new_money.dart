// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/money_management/money_management.dart';

/// Money FAB fragment
///
/// Calls the [_MoneyAlert] fragment
class _MoneyFab extends StatelessWidget {
  const _MoneyFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => const _MoneyAlert(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

/// Money Alert to add a new moneyCalc
///
/// Asks the user to add a new moneyCalc
class _MoneyAlert extends StatefulWidget {
  const _MoneyAlert({Key? key}) : super(key: key);

  @override
  State<_MoneyAlert> createState() => _MoneyAlertState();
}

class _MoneyAlertState extends State<_MoneyAlert> {
  final TextEditingController _buyer = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    _buyer.text = AuthService.getUser!.uid;
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
              style: Theme.of(context).textTheme.bodyText2,
              controller: _buyer,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!
                    .settings_groupManagement_addUser_uid,
              ),
              validator: (value) {
                if (value is! String) {
                  return 'not a Number';
                }
                return null;
              },
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
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
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () => _onSubmit(),
          child: Text(AppLocalizations.of(context)!.form_submit),
        ),
      ],
    );
  }

  /// saves the input to cloud firestore
  Future<void> _onSubmit() async {
    final DateTime _date = DateTime.now();

    await DatabaseService.saveMoneyCalc(
      MoneyCalc(
        buyer: _buyer.value.text,
        amount: double.parse(_amount.value.text) * -1,
        timestamp: _date,
        // participants: participants,
      ),
    );

    Navigator.pop(context);
  }
}

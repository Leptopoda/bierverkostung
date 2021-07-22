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
      onPressed: () => showModalBottomSheet(
        isScrollControlled: true,
        shape: _MoneyAlert.shape,
        context: context,
        builder: (BuildContext context) {
          return const _MoneyAlert();
        },
      ),
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

  /// The used theme providing rounded corners
  static const shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );
}

class _MoneyAlertState extends State<_MoneyAlert> {
  late String _buyer;
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    _buyer = AuthService.getUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(AppLocalizations.of(context).moneyCalculator_newCalculation),
            FutureBuilder(
              future: DatabaseService.group,
              builder: (BuildContext context, AsyncSnapshot<Group> snapshot) {
                if (snapshot.hasError) {
                  return SomethingWentWrong(
                    error: snapshot.error.toString(),
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
                        child: Text(AppLocalizations.of(context).noItemsFound),
                      );
                    }

                    final Group _groupData = snapshot.data!;
                    return DropdownButtonFormField(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      style: Theme.of(context).textTheme.bodyText2,
                      value: _buyer,
                      items: _groupData.members.map<DropdownMenuItem<String>>(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: _UserProfileInformation(uid: val),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) => setState(() => _buyer = val!),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .settings_groupManagement_addUser_uid,
                      ),
                    );
                }
              },
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: _amount,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).moneyCalculator_amount,
              ),
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value != null && !RegExp('(?=.*[A-Z])').hasMatch(value)) {
                  return AppLocalizations.of(context)
                      .moneyCalculator_notANumber;
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context).alert_escape),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () => _onSubmit(),
                  child: Text(AppLocalizations.of(context).alert_continue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// saves the input to cloud firestore
  Future<void> _onSubmit() async {
    final DateTime _date = DateTime.now();

    await DatabaseService.saveMoneyCalc(
      MoneyCalc(
        buyer: _buyer,
        amount: double.parse(_amount.value.text) * -1,
        timestamp: _date,
        // participants: participants,
      ),
    );

    Navigator.pop(context);
  }
}

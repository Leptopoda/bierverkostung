// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/group_settings/group_management.dart';

/// Group management fragment
///
/// This screen enables the user to add other useres to his current group
class _AddUser extends StatefulWidget {
  const _AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<_AddUser> {
  final TextEditingController _uid = TextEditingController();
  final TextEditingController _newUser = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _uid.dispose();
    _newUser.dispose();
  }

  /// calls the [_QRScanner] fragment
  static void _scanQR(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const _QRScanner(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? _text = Theme.of(context).textTheme.bodyText2;
    final User _user = AuthService.getUser!;
    _uid.text = _user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.settings_groupManagement_addUser),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              style: _text,
              readOnly: true,
              controller: _uid,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!
                    .settings_groupManagement_addUser_yourID,
                suffixIcon: const Icon(Icons.group_outlined),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => _scanQR(context),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: Container(
                  height: 230,
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      QrImage(
                        data: jsonEncode({'user': _user.uid}),
                        size: 175.0,
                      ),
                      Text(AppLocalizations.of(context)!
                          .settings_groupManagement_addUser_scanCode),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: _text,
              controller: _newUser,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!
                    .settings_groupManagement_addUser_uid,
                suffixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => (value == null || value.length != 28)
                  ? AppLocalizations.of(context)!
                      .settings_groupManagement_addUser_invalidUid
                  : null,
            ),
            ElevatedButton.icon(
              onPressed: () => _submit(context),
              icon: const Icon(Icons.group_add_outlined),
              label: Text(AppLocalizations.of(context)!
                  .settings_groupManagement_addUser_addToGroup),
            ),
            ElevatedButton.icon(
              onPressed: () => AuthService.refreshToken(),
              icon: const Icon(Icons.refresh_outlined),
              label: Text(AppLocalizations.of(context)!
                  .settings_groupManagement_addUser_refreshToken),
            ),
          ],
        ),
      ),
    );
  }

  /// validates the input and adds the user to the current group
  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String _groupID = AuthService.groupID;
      final HttpsCallableResult<dynamic> result =
          await CloudFunctionsService.setGroup(
              uid: _newUser.value.text, guid: _groupID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.data.toString()),
        ),
      );
    }
  }
}

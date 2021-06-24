// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'user_settings.dart';

/// Log out Alert
///
/// greets the user on logout
class _LogOutAlert extends StatelessWidget {
  const _LogOutAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_logOut),
      content: Text(
        AppLocalizations.of(context)!.settings_logOut_goodbye,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () async {
            await AuthService.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.settings_logOut_logedOut),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.settings_logOut),
        ),
      ],
    );
  }
}

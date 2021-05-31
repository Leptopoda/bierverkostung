// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/auth.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext _) => (AuthService().getUser()!.isAnonymous)
            ? const LogOutAnonAlert()
            : const LogOutAlert());
    return Container();
  }
}

class LogOutAlert extends StatelessWidget {
  const LogOutAlert({Key? key}) : super(key: key);

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
            await AuthService().signOut();
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

class LogOutAnonAlert extends StatelessWidget {
  const LogOutAnonAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_logOut_caution),
      content: Text(AppLocalizations.of(context)!.settings_logOut_cautionAlert),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_escape),
        ),
        TextButton(
          onPressed: () async {
            await AuthService().signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.settings_logOut_logedOut),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}

/* class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('loged out '),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Log Out'),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext _) => const LogOutAlert(),
              ),
              child: const Text('Neue ID'),
            ),
          ],
        ),
      ),
    );
  }
} */

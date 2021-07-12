// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/login/login.dart';

/// Validate Email Alert
///
/// Hintes the user to validate the email within 7 days.
class _ValidateEmailAlert extends StatelessWidget {
  const _ValidateEmailAlert({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.validate_email),
      content: Text(AppLocalizations.of(context)!.validate_email_banner),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.alert_continue),
        ),
      ],
    );
  }
}

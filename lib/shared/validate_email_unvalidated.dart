// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/home.dart';

/// Unvalidated Email Alert
///
/// Alerts the user to validate their email adress.
/// This alert should not be dismissible and gives
/// the option to resend the verification mail.
class _UnvalidatedEmailAlert extends StatelessWidget {
  const _UnvalidatedEmailAlert({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.validate_email_unvalidated),
      content: Text(AppLocalizations.of(context)!
          .validate_email_unvalidated_banner(AuthService.userEmail!)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            AuthService.validateMail;
          },
          child: Text(AppLocalizations.of(context)!.validate_email_resend),
        ),
        TextButton(
          onPressed: () {
            AuthService.refreshToken();
            if (AuthService.hasValidatedEmail) Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.validate_email_notValidated),
              ),
            );
          },
          child: Text(AppLocalizations.of(context)!.validate_email_refresh),
        ),
      ],
    );
  }
}

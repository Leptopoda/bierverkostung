// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/home.dart';

class _WelcomeScreen {
  const _WelcomeScreen._();

  static Future<void> showWelcomeScreen(BuildContext context) async {
    if (await LocalDatabaseService.getFirstLogin()) {
      _checkEmailValidation(context);
    } else {
      _runWelcomeScreen(context);
    }
  }

  static Future<void> _checkEmailValidation(BuildContext context) async {
    debugPrint('Checking Email Validation');
    if (!AuthService.hasValidatedEmail) {
      AuthService.refreshToken();
      final int _days = AuthService.getUser?.metadata.creationTime
              ?.difference(DateTime.now())
              .inDays ??
          0;
      if (_days <= -7) {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => const _UnvalidatedEmailAlert(),
        );
      }
    }
  }

  static Future<void> _runWelcomeScreen(BuildContext context) async {
    debugPrint('running welcome Screen');
    await NotificationService.askPermission();
    await showDialog(
      context: context,
      builder: (_) => const _ValidateEmailAlert(),
    );

    await LocalDatabaseService.setFirstLogin();
  }
}

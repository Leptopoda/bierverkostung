// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/notifications.dart';

/// Notification Settings
///
/// Users can ask for notification permission here
class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => NotificationService.askPermission(),
        child: Text(AppLocalizations.of(context).settings_notification_enable),
      ),
    );
  }
}

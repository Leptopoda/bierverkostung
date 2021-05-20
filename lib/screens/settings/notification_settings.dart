// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/notifications.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => NotificationService().askPermission(),
        child: const Text('Enable Notifications'),
      ),
    );
  }
}

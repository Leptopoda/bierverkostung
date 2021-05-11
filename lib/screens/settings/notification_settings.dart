// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/services/notifications.dart';
import 'package:bierverkostung/models/users.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData _user = Provider.of<UserData?>(context)!;

    return Center(
      child: ElevatedButton(
        onPressed: () => NotificationService().askPermission(_user),
        child: const Text('Enable Notifications'),
      ),
    );
  }
}

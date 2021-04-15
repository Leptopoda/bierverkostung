// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/settings/user_settings.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_outline),
      tooltip: 'Log Out',
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext _) => const LogOutAlert(),
      ),
    );
  }
}

class GroupManagement extends StatelessWidget {
  const GroupManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.group_add_outlined),
      tooltip: 'Group Management',
      onPressed: () {
        Navigator.pushNamed(context, '/Settings/Groups');
      },
    );
  }
}

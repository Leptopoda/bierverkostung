// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/settings/user_settings.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text(
              'Log Out',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext _) => const LogOutAlert(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group_add_outlined),
            title: const Text(
              'Group Management',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/Settings/Groups'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              'About this App',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/Settings/About'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.import_export_outlined),
            title: const Text(
              'Group Management',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/Settings/Import'),
          ),
        ],
      ),
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:bierverkostung/screens/settings/user_settings.dart';
import 'package:bierverkostung/screens/settings/about_us_settings.dart';
import 'package:bierverkostung/screens/settings/group_management.dart';
import 'package:bierverkostung/screens/settings/import_data_settings.dart';
import 'package:bierverkostung/screens/settings/notification_settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _names = [
    'Log Out',
    'Group Management',
    'Notifications',
    'Import Data',
    'About this App',
  ];

  static const List<ListTile> _items = [
    ListTile(
      leading: Icon(Icons.login_outlined),
      title: Text(
        'Log Out',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
    ListTile(
      leading: Icon(Icons.group_add_outlined),
      title: Text(
        'Group Management',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
    ListTile(
      leading: Icon(Icons.notifications_active_outlined),
      title: Text(
        'Notifications',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
    ListTile(
      leading: Icon(Icons.import_export_outlined),
      title: Text(
        'Import Data',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
    ListTile(
      leading: Icon(Icons.info_outline),
      title: Text(
        'About this App',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
  ];

  static const List<Widget> _actions = [
    LogOut(),
    GroupScreen(),
    NotificationSettings(),
    ImportDataSettings(),
    AboutUsSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveListScaffold.builder(
      scaffoldKey: _scaffoldKey,
      detailBuilder: (BuildContext context, int? index, bool tablet) {
        return DetailsScreen(
          body: SettingsDetail(
            items: _actions,
            row: index,
            tablet: tablet,
            title: _names,
          ),
        );
      },
      nullItems: const Center(child: CircularProgressIndicator()),
      emptyItems: const Center(child: Text('No Items Found')),
      slivers: const <Widget>[
        SliverAppBar(
          title: Text('Settings'),
        ),
      ],
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        return _items[index];
      },
    );
  }
}

class SettingsDetail extends StatelessWidget {
  const SettingsDetail({
    Key? key,
    required this.items,
    required this.row,
    required this.tablet,
    required this.title,
  }) : super(key: key);

  final List<Widget> items;
  final int? row;
  final bool tablet;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: !tablet,
        title: Text(title[row!]),
        // actions: tablet ? actionBarItems : null,
      ),
      body: (row != null) ? items[row!] : null,
    );
  }
}

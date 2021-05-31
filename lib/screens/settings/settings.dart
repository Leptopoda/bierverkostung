// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/shared/responsive_scaffold_helper.dart';

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

  static const List<Widget> _actions = [
    LogOut(),
    GroupScreen(),
    NotificationSettings(),
    ImportDataSettings(),
    AboutUsSettings()
  ];

  @override
  Widget build(BuildContext context) {
    final List<ListTile> _items = [
      ListTile(
        leading: const Icon(Icons.login_outlined),
        title: Text(
          AppLocalizations.of(context)!.settings_logOut,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: const Icon(Icons.group_add_outlined),
        title: Text(
          AppLocalizations.of(context)!.settings_groupManagement,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: const Icon(Icons.notifications_active_outlined),
        title: Text(
          AppLocalizations.of(context)!.settings_notification,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: const Icon(Icons.import_export_outlined),
        title: Text(
          AppLocalizations.of(context)!.settings_importData,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: Text(
          AppLocalizations.of(context)!.settings_aboutUs,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    ];

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
      nullItems: ResponsiveScaffoldNullItems(),
      emptyItems: ResponsiveScaffoldEmptyItems(),
      tabletItemNotSelected: ResponsiveScaffoldNoItemSelected(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
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
        automaticallyImplyLeading: !tablet,
        title: Text(title[row!]),
        // actions: tablet ? actionBarItems : null,
      ),
      body: (row != null) ? items[row!] : null,
    );
  }
}

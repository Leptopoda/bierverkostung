// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/gen/assets.gen.dart';

class AboutUsSettings extends StatefulWidget {
  const AboutUsSettings({Key? key}) : super(key: key);

  @override
  _AboutUsSettingsState createState() => _AboutUsSettingsState();
}

class _AboutUsSettingsState extends State<AboutUsSettings> {
  @override
  Widget build(BuildContext context) {
    _aboutUsDialog(context);
    return Container();
  }

  Future<void> _aboutUsDialog(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    showAboutDialog(
      context: context,
      applicationIcon: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Assets.icon.icon.svg(),
      ),
      applicationName: packageInfo.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese:
          AppLocalizations.of(context)!.settings_aboutUs_copyright,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
            text:
                '${AppLocalizations.of(context)!.settings_aboutUs_desc}https://gitlab.rimikis.de/Leptopoda/bierverkostung',
          ),
        ),
      ],
    );
  }
}

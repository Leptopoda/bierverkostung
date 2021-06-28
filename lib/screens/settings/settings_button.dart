// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Button opening the screen for the [Settings]
@Deprecated('we directly implemented it into the [Home] screen')
class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined),
      tooltip: AppLocalizations.of(context)!.settings,
      onPressed: () => Navigator.pushNamed(context, '/Settings'),
    );
  }
}

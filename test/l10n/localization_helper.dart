// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Helper Widget for l10n
///
/// injects the generated lacalization strings
/// to test the localized [child] widget.
/// Only the en localization will be available
class L10nHelper extends StatelessWidget {
  /// Child Widget to load the helper for
  final Widget child;
  const L10nHelper({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: child,
    );
  }
}

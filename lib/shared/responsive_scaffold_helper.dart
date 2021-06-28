// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// No Items Selected
///
/// Message that gets displayed when no item has been
/// used in a responsive scaffold
class ResponsiveScaffoldNoItemSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.noItemSelected));
  }
}

/// No Items available
///
/// gets displayed when the state of the master list is null
/// it indicates that something is still loading
class ResponsiveScaffoldNullItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// Empty List
///
/// Message that gets displayed when the master list has been
/// loaded but is an empty list
class ResponsiveScaffoldEmptyItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.noItemsFound));
  }
}

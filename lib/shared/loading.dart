// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Loading Pge
///
/// displays a [CircularProgressIndicator] indicating the loading state
/// keep in mind the indicator is inside a [Scaffold] with an [AppBar].
/// Do not use this inside other UI elements
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.loading ?? 'loading'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ResponsiveScaffoldNoItemSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text("No Item Selected"),
      ),
    );
  }
}

class ResponsiveScaffoldNullItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class ResponsiveScaffoldEmptyItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: const Center(child: Text('No Items Found')),
    );
  }
}

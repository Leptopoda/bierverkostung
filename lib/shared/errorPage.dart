// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SomethingWentWrong'),
      ),
      body: Center(
        child: const Text(
            'Die Einhörner versuchen dieses Problem schnellstens zu beheben',
            style: TextStyle(fontSize: 18.0)),
      ),
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  final String error;
  const SomethingWentWrong({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Something went wrong'),
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/error.png'),
              Text(
                  'Die Einhörner versuchen dieses Problem schnellstens zu beheben. Um ihnen zu helfen gebe folgenden error weiter: $error',
                  style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}

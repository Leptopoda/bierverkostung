// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/auth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //TODO: better error handling
            final bool _result = await AuthService().registerAnon();
            if (_result) {
              // TODO: fix or remove
              /* ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loged in'),
                ),
              ); */
            } else {
              Navigator.pushNamed(context, '/error',
                  arguments: 'error signing in');
            }
          },
          child: const Text('Register Anonymously'),
        ),
      ),
    );
  }
}

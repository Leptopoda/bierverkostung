// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bierverkostung/shared/error_page.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //TODO: better error handling
            final _result = await _auth.signInAnonymously();
            final User? _user = _result.user;
            if (_user == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SomethingWentWrong(
                    error: 'error signing in',
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Loged in $_user'),
                ),
              );
            }
          },
          child: const Text('Register Anonymously'),
        ),
      ),
    );
  }
}

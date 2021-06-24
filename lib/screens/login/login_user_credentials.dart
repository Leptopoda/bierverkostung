// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/services/firebase/auth.dart';

/// Register User
///
/// Screen for registering new users
@Deprecated('This is only a example screen')
class UserCredentialsAlert extends StatelessWidget {
  const UserCredentialsAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: const Text('Register Anonymously'),
            ),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext _) => const UserCredentialsAlert(),
              ),
              child: const Text('Register with Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                final bool _result = await AuthService.registerAnon();
                if (_result) {
                } else {
                  Navigator.pushNamed(context, '/error',
                      arguments: 'error signing in');
                }
              },
              child: const Text('Sign in with email'),
            ),
          ],
        ),
      ),
    );
  }
}

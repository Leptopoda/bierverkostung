// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/main.dart';

/// Login Controller
///
/// decides wether to show the login or home screen
class _LoginController extends StatelessWidget {
  const _LoginController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User?>(context);
    final bool _loggedIn = _user != null;

    if (_loggedIn) {
      return const MyHome();
    } else {
      return const Login();
    }
  }
}

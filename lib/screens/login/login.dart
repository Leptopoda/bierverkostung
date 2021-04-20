// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:bierverkostung/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Bierverkosung',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Sign in',
                style: _text,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: _text,
              controller: _mailController,
                keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-Mail',
              ),
              validator: (email) =>
                  (email != null && !EmailValidator.validate(email))
                      ? 'Keine gültige Email'
                      : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: _text,
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: (String? pwd) => _validatePassword(pwd),
            ),
            TextButton(
              onPressed: () => _forgotPassword(),
              child: const Text('Forgot Password'),
            ),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(),
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => _registerWithEmailAndPassword(),
                  child: const Text(
                    'Register',
                    style: _text,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Login Anonymously'),
                TextButton(
                  onPressed: () => _registerAnon(),
                  child: const Text(
                    'Anonymous',
                    style: _text,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerAnon() async {
    final bool _result = await AuthService().registerAnon();
    if (_result) {
    } else {
      Navigator.pushNamed(context, '/error', arguments: 'error signing in');
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      final bool _result = await AuthService().signInWithEmailAndPassword(
        _mailController.text,
        _passwordController.text,
      );
      if (_result) {
      } else {
        Navigator.pushNamed(context, '/error', arguments: 'error signing in');
      }
    }
  }

  Future<void> _registerWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      final bool _result = await AuthService().registerWithEmailAndPassword(
        _mailController.text,
        _passwordController.text,
      );
      if (_result) {
      } else {
        Navigator.pushNamed(context, '/error', arguments: 'error signing in');
      }
    }
  }

  Future<void> _forgotPassword() async {}

  String? _validatePassword(String? pwd) {
    if (pwd == null) {
      return 'empty field';
    }

    if (!RegExp('(?=.*[A-Z])').hasMatch(pwd)) {
      return 'should contain at least one upper case';
    }

    if (!RegExp('(?=.*[a-z])').hasMatch(pwd)) {
      return 'should contain at least one lower case';
    }

    if (!RegExp('(?=.*?[0-9])').hasMatch(pwd)) {
      return 'should contain at least one digit';
    }

    /* if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(pwd)) {
      return 'should contain at least one Special character';
    } */

    if (!RegExp(r'.{8,}$').hasMatch(pwd)) {
      return 'Must be at least 8 characters in length';
    }

    return null;
  }
}

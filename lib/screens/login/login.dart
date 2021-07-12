// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

import 'package:bierverkostung/services/firebase/auth.dart';

part 'package:bierverkostung/shared/validate_email.dart';

/// Login Screen
///
/// Shows the login/registration UI
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
        title: Text(AppLocalizations.of(context)!.login),
      ),
      body: Form(
        key: _formKey,
        child: AutofillGroup(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.beertasting,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.login_signIn,
                  style: _text,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: _text,
                controller: _mailController,
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.login_eMail,
                ),
                validator: (email) =>
                    (email != null && !EmailValidator.validate(email))
                        ? AppLocalizations.of(context)!.login_eMail_invalid
                        : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: _text,
                obscureText: true,
                controller: _passwordController,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.login_password,
                ),
                validator: (String? pwd) => _validatePassword(pwd),
              ),
              TextButton(
                onPressed: () => _forgotPassword(),
                child:
                    Text(AppLocalizations.of(context)!.login_password_forgot),
              ),
              ElevatedButton(
                onPressed: () => _signInWithEmailAndPassword(),
                child: Text(AppLocalizations.of(context)!.login),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.login_newAccount),
                  TextButton(
                    onPressed: () => _registerWithEmailAndPassword(),
                    child: Text(
                      AppLocalizations.of(context)!.login_register,
                      style: _text,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.login_anonymously),
                  TextButton(
                    onPressed: () => _registerAnon(),
                    child: Text(
                      AppLocalizations.of(context)!.login_anonymous,
                      style: _text,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// signs in with a new annonymous [User]
  Future<void> _registerAnon() async {
    final bool _result = await AuthService.registerAnon();
    if (_result) {
    } else {
      Navigator.pushNamed(context, '/error',
          arguments: AppLocalizations.of(context)!.login_error);
    }
  }

  /// signs in with the specified email and password
  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      final bool _result = await AuthService.signInWithEmailAndPassword(
        _mailController.text,
        _passwordController.text,
      );
      if (_result) {
      } else {
        Navigator.pushNamed(context, '/error',
            arguments: AppLocalizations.of(context)!.login_error);
      }
    }
  }

  /// registers anew user with the provided email and password
  Future<void> _registerWithEmailAndPassword() async {
    //if (isNewUser) TextField(controller: newPassword, autofillHints: [AutofillHints.newPassword]),
    //if (isNewUser) TextField(ontroller: repeatNewPassword, autofillHints: [AutofillHints.newPassword]),

    if (_formKey.currentState!.validate()) {
      final bool _result = await AuthService.registerWithEmailAndPassword(
        _mailController.text,
        _passwordController.text,
      );
      print('hallo $_result');
      if (_result) {
        print('waiting');
        await showDialog(
            context: context, builder: (_) => const _ValidateEmailAlert());
      } else {
        Navigator.pushNamed(context, '/error',
            arguments: AppLocalizations.of(context)!.login_error);
      }
    }
  }

  /// starts the forgotPassword flow to reset the password
  Future<void> _forgotPassword() async {}

  /// validates the new password against our security criteria
  String? _validatePassword(String? pwd) {
    if (pwd == null) {
      return AppLocalizations.of(context)!.login_password_empty;
    }

    if (!RegExp('(?=.*[A-Z])').hasMatch(pwd)) {
      return AppLocalizations.of(context)!.login_password_upperCase;
    }

    if (!RegExp('(?=.*[a-z])').hasMatch(pwd)) {
      return AppLocalizations.of(context)!.login_password_lowerCase;
    }

    if (!RegExp('(?=.*?[0-9])').hasMatch(pwd)) {
      return AppLocalizations.of(context)!.login_password_digit;
    }

    /* if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(pwd)) {
      return 'should contain at least one Special character';
    } */

    if (!RegExp(r'.{8,}$').hasMatch(pwd)) {
      return AppLocalizations.of(context)!.login_password_length;
    }

    return null;
  }
}

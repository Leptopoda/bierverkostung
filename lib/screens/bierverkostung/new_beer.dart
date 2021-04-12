// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/models/breweries.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import 'package:bierverkostung/services/database.dart';
import 'package:bierverkostung/models/beers.dart';

class NewBeer extends StatefulWidget {
  final User user;

  const NewBeer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewBeerState();
}

class _NewBeerState extends State<NewBeer> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _beerName = TextEditingController();
  final TextEditingController _brewery = TextEditingController();
  final TextEditingController _style = TextEditingController();
  final TextEditingController _originalWort = TextEditingController();
  final TextEditingController _alcohol = TextEditingController();
  final TextEditingController _ibu = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _specifics = TextEditingController();
  final TextEditingController _beerNotes = TextEditingController();

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  @override
  void dispose() {
    _beerName.dispose();
    _brewery.dispose();
    _style.dispose();
    _originalWort.dispose();
    _alcohol.dispose();
    _ibu.dispose();
    _ingredients.dispose();
    _specifics.dispose();
    _beerNotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Beer'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: <Widget>[
            TextFormField(
              style: _text,
              controller: _beerName,
              decoration: const InputDecoration(
                labelText: 'Beer Name',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _brewery,
              decoration: const InputDecoration(
                labelText: 'Brewery',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _style,
              decoration: const InputDecoration(
                labelText: 'Beer Style',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _originalWort,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                ThousandsFormatter(allowFraction: true),
              ],
              decoration: const InputDecoration(
                labelText: 'Original Wort',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _alcohol,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                ThousandsFormatter(allowFraction: true),
              ],
              decoration: const InputDecoration(
                labelText: 'Alcohol %',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _ibu,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'IBU',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _ingredients,
              decoration: const InputDecoration(
                labelText: 'Ingredients',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _specifics,
              decoration: const InputDecoration(
                labelText: 'Specifics',
              ),
            ),
            TextFormField(
              style: _text,
              controller: _beerNotes,
              decoration: const InputDecoration(
                labelText: 'Beer Notes',
              ),
            ),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
      _formKey.currentState!.save();

      final Beer _bier1 = Beer(
        beerName: _beerName.value.text,
        brewery: (_brewery.value.text != '')
            ? Brewery(breweryName: _brewery.value.text)
            : null,
        style: _style.value.text,
        originalWort: (_originalWort.value.text != '')
            ? double.parse(_originalWort.value.text)
            : null,
        alcohol: (_alcohol.value.text != '')
            ? double?.parse(_alcohol.value.text)
            : null,
        ibu: (_ibu.value.text != '') ? int.parse(_ibu.value.text) : null,
        ingredients: _ingredients.value.text,
        specifics: _specifics.value.text,
        beerNotes: _beerNotes.value.text,
      );

      await DatabaseService(uid: widget.user.uid).saveBeer(_bier1);

      Navigator.of(context).pop();
    }
  }
}

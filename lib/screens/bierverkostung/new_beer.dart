// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart'
    show ThousandsFormatter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/models/breweries.dart';
import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/beers.dart';

class NewBeer extends StatelessWidget {
  const NewBeer({
    Key? key,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _beerName = TextEditingController();
  static final TextEditingController _brewery = TextEditingController();
  static final TextEditingController _style = TextEditingController();
  static final TextEditingController _originalWort = TextEditingController();
  static final TextEditingController _alcohol = TextEditingController();
  static final TextEditingController _ibu = TextEditingController();
  static final TextEditingController _ingredients = TextEditingController();
  static final TextEditingController _specifics = TextEditingController();
  static final TextEditingController _beerNotes = TextEditingController();

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.beer_newBeer),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: <Widget>[
            TextFormField(
              style: _text,
              controller: _beerName,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_name,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _brewery,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_brewery,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _style,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_style,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _originalWort,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                ThousandsFormatter(allowFraction: true),
              ],
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_originalWort,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _alcohol,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                ThousandsFormatter(allowFraction: true),
              ],
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_alcohol,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _ibu,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_ibu,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _ingredients,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_ingredients,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _specifics,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_specifics,
              ),
            ),
            TextFormField(
              style: _text,
              controller: _beerNotes,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.beer_notes,
              ),
            ),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: Text(AppLocalizations.of(context)!.form_submit),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loading_processingData),
        ),
      );
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

      final String? _groupID =
          await AuthService.getClaim('group_id') as String?;
      await DatabaseService(groupID: _groupID).saveBeer(_bier1.toMap());

      Navigator.of(context).pop();
    }
  }
}

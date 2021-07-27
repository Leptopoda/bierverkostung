// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart'
    show ThousandsFormatter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/models/breweries.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/services/firebase/cloud_storage.dart';
import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/shared/image_provider_modal.dart';
import 'package:bierverkostung/shared/tasting_beer_card.dart';

part 'package:bierverkostung/screens/beer/beer_images.dart';

/// Screen to add a new Beer
///
/// It exposes the fields of a [Beer] into a UI
/// set [beer] in order to get a screen to display the given beer
class BeerInfoList extends StatefulWidget {
  /// initial value,
  final Beer? beer;
  final bool selectable;
  final bool tablet;
  const BeerInfoList({
    Key? key,
    this.beer,
    this.selectable = false,
    this.tablet = false,
  }) : super(key: key);

  @override
  _BeerInfoListState createState() => _BeerInfoListState();
}

class _BeerInfoListState extends State<BeerInfoList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Beer _beer;
  late bool _readOnly;

  late TextEditingController _beerName;
  late TextEditingController _brewery;
  late TextEditingController _style;
  late TextEditingController _originalWort;
  late TextEditingController _alcohol;
  late TextEditingController _ibu;
  late TextEditingController _ingredients;
  late TextEditingController _specifics;
  late TextEditingController _beerNotes;

  List<String> _images = [];

  @override
  void initState() {
    super.initState();

    _beerName = TextEditingController(text: widget.beer?.beerName);
    _brewery = TextEditingController(text: widget.beer?.brewery?.breweryName);
    _style = TextEditingController(text: widget.beer?.style);
    _originalWort =
        TextEditingController(text: widget.beer?.originalWort?.toString());
    _alcohol = TextEditingController(text: widget.beer?.alcohol?.toString());
    _ibu = TextEditingController(text: widget.beer?.ibu?.toString());
    _ingredients = TextEditingController(text: widget.beer?.ingredients);
    _specifics = TextEditingController(text: widget.beer?.specifics);
    _beerNotes = TextEditingController(text: widget.beer?.beerNotes);

    if (widget.beer?.images != null && widget.beer!.images!.isNotEmpty) {
      _images = widget.beer!.images!;
    }

    if (widget.beer == null) {
      setState(() => _readOnly = false);
    } else {
      _beer = widget.beer!;
      setState(() => _readOnly = true);
    }
  }

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
    final TextStyle? _text = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.tablet,
        title:
            !widget.tablet ? Text(AppLocalizations.of(context).beerOne) : null,
        actions: [
          if (_readOnly)
            IconButton(
              tooltip: AppLocalizations.of(context).beer_editBeer,
              onPressed: () => setState(() => _readOnly = false),
              icon: const Icon(Icons.edit_outlined),
            ),
          if (widget.beer != null && _readOnly && widget.selectable)
            IconButton(
              tooltip: AppLocalizations.of(context).beer_selectBeer,
              onPressed: () => Navigator.pop(context, _beer),
              icon: const Icon(Icons.check_outlined),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TastingBeerCard(
                children: <Widget>[
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _beerName,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_name,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _brewery,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_brewery,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _style,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_style,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _originalWort,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      ThousandsFormatter(allowFraction: true),
                    ],
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_originalWort,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _alcohol,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      ThousandsFormatter(allowFraction: true),
                    ],
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_alcohol,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _ibu,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_ibu,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _ingredients,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_ingredients,
                    ),
                  ),
                  TextFormField(
                    style: _text,
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    controller: _specifics,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_specifics,
                    ),
                  ),
                  TextFormField(
                    enabled: !_readOnly,
                    readOnly: _readOnly,
                    style: _text,
                    controller: _beerNotes,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).beer_notes,
                    ),
                  ),
                ],
              ),
              if (!_readOnly ||
                  (widget.beer?.images != null &&
                      widget.beer!.images!.isNotEmpty))
                TastingBeerCard(
                  children: [
                    if (_readOnly && _images.isNotEmpty)
                      SizedBox(
                        height: 150,
                        width: 500,
                        child: _BeerImageView(
                          imagePaths: widget.beer!.images!,
                        ),
                      ),
                    if (!_readOnly)
                      SizedBox(
                        height: 150,
                        width: 500,
                        child: _BeerImage(
                          onChanged: (images) => _images = images,
                        ),
                      ),
                  ],
                ),
              if (!_readOnly)
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(AppLocalizations.of(context).form_submit),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Validates and saves the new beer
  Future<void> _submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).loading_processingData),
        ),
      );
      _formKey.currentState!.save();

      final List<String> _imageUrls = [];

      for (final String path in _images) {
        final String? _url = await CloudStorageService.uploadBeerImage(
            path, _beerName.value.text);
        if (_url != null) {
          _imageUrls.add(_url);
        }
      }

      _beer = Beer(
        beerName: _beerName.value.text,
        brewery: (_brewery.value.text != '')
            ? Brewery(breweryName: _brewery.value.text)
            : null,
        style: _style.value.text,
        originalWort: double?.tryParse(_originalWort.value.text),
        alcohol: double?.tryParse(_alcohol.value.text),
        ibu: int?.tryParse(_ibu.value.text),
        ingredients: _ingredients.value.text,
        specifics: _specifics.value.text,
        beerNotes: _beerNotes.value.text,
        images: _imageUrls,
      );

      await DatabaseService.saveBeer(_beer);

      Navigator.pop(context, _beer);
    }
  }
}

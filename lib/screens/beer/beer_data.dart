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

part 'package:bierverkostung/screens/beer/beer_images.dart';

/// Screen to add a new Beer
///
/// It exposes the fields of a [Beer] into a UI
class NewBeer extends StatelessWidget {
  const NewBeer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).beer_newBeer),
      ),
      body: const SingleChildScrollView(child: BeerInfoList()),
    );
  }
}

class BeerInfoList extends StatefulWidget {
  final Beer? beer;
  const BeerInfoList({
    this.beer,
    Key? key,
  }) : super(key: key);

  @override
  _BeerInfoListState createState() => _BeerInfoListState();
}

class _BeerInfoListState extends State<BeerInfoList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  late bool readOnly;

  @override
  void initState() {
    super.initState();

    _beerName = TextEditingController(text: widget.beer?.beerName);
    _brewery = TextEditingController(text: widget.beer?.brewery?.breweryName);
    _style = TextEditingController(text: widget.beer?.style);
    _originalWort =
        TextEditingController(text: widget.beer?.originalWort.toString());
    _alcohol = TextEditingController(text: widget.beer?.alcohol.toString());
    _ibu = TextEditingController(text: widget.beer?.ibu.toString());
    _ingredients = TextEditingController(text: widget.beer?.ingredients);
    _specifics = TextEditingController(text: widget.beer?.specifics);
    _beerNotes = TextEditingController(text: widget.beer?.beerNotes);
    setState(() => readOnly = widget.beer != null);
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

    final List<Widget> _widgets = <Widget>[
      TextFormField(
        readOnly: readOnly,
        style: _text,
        controller: _beerName,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_name,
        ),
      ),
      TextFormField(
        readOnly: readOnly,
        style: _text,
        controller: _brewery,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_brewery,
        ),
      ),
      TextFormField(
        readOnly: readOnly,
        style: _text,
        controller: _style,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_style,
        ),
      ),
      TextFormField(
        readOnly: readOnly,
        style: _text,
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
        readOnly: readOnly,
        style: _text,
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
        readOnly: readOnly,
        style: _text,
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
        readOnly: readOnly,
        style: _text,
        controller: _ingredients,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_ingredients,
        ),
      ),
      TextFormField(
        readOnly: readOnly,
        style: _text,
        controller: _specifics,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_specifics,
        ),
      ),
      TextFormField(
        readOnly: readOnly,
        style: _text,
        controller: _beerNotes,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).beer_notes,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ];

    if (readOnly) {
      if (widget.beer?.images != null) {
        _widgets.addAll([
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: 500,
            child: _BeerImageView(
              imagePaths: widget.beer!.images!,
            ),
          ),
        ]);
      }
    } else {
      _widgets.addAll([
        SizedBox(
          height: 150,
          width: 500,
          child: _BeerImage(
            onChanged: (images) => _images = images,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () => _submit(),
          child: Text(AppLocalizations.of(context).form_submit),
        ),
      ]);
    }

    return Form(
      key: _formKey,
      child: _BeerCard(
        children: _widgets,
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

      final _bier = Beer(
        beerName: _beerName.value.text,
        brewery: (_brewery.value.text != '')
            ? Brewery(breweryName: _brewery.value.text)
            : null,
        style: _style.value.text,
        originalWort: double.tryParse(_originalWort.value.text),
        alcohol: double.tryParse(_alcohol.value.text),
        ibu: int.tryParse(_ibu.value.text),
        ingredients: _ingredients.value.text,
        specifics: _specifics.value.text,
        beerNotes: _beerNotes.value.text,
        images: _imageUrls,
      );

      await DatabaseService.saveBeer(_bier);

      Navigator.pop(context);
    }
  }
}

/// Widget to display Images of a beer
class _BeerImageView extends StatelessWidget {
  final List<String> imagePaths;
  const _BeerImageView({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.all(10),
      itemExtent: 100,
      itemCount: imagePaths.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          color: Theme.of(context).accentColor,
          child: Image.network(imagePaths[i]),
        );
      },
    );
  }
}

class _BeerCard extends StatelessWidget {
  final List<Widget> children;
  const _BeerCard({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: children,
      ),
    );
  }
}

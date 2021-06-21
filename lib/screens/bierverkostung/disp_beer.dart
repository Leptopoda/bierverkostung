// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart'
    show ThousandsFormatter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/models/beers.dart';

class DispBeer {
  final Beer beer;

  const DispBeer({
    required this.beer,
  });

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  List<Widget> dispBeer(BuildContext context) {
    return <Widget>[
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.beerName,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_name,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.brewery?.breweryName,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_brewery,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.style,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_style,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.originalWort.toString(),
        inputFormatters: <TextInputFormatter>[
          ThousandsFormatter(allowFraction: true),
        ],
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_originalWort,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.alcohol.toString(),
        inputFormatters: <TextInputFormatter>[
          ThousandsFormatter(allowFraction: true),
        ],
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_alcohol,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.ibu.toString(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_ibu,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.ingredients,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_ingredients,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.specifics,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_specifics,
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.beerNotes,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.beer_notes,
        ),
      ),
    ];
  }
}

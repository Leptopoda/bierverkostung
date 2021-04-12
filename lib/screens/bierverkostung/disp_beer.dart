// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import 'package:bierverkostung/models/beers.dart';

class DispBeer {
  final Beer beer;

  const DispBeer({
    required this.beer,
  });

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  List<Widget> dispBeer() {
    print(beer.alcohol);
    return <Widget>[
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.beerName,
        decoration: const InputDecoration(
          labelText: 'Beer Name',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.brewery?.breweryName,
        decoration: const InputDecoration(
          labelText: 'Brewery',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.style,
        decoration: const InputDecoration(
          labelText: 'Beer Style',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.originalWort as String?,
        inputFormatters: <TextInputFormatter>[
          ThousandsFormatter(allowFraction: true),
        ],
        decoration: const InputDecoration(
          labelText: 'Original Wort',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.alcohol as String?,
        inputFormatters: <TextInputFormatter>[
          ThousandsFormatter(allowFraction: true),
        ],
        decoration: const InputDecoration(
          labelText: 'Alcohol %',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.ibu as String?,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          labelText: 'IBU',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.ingredients,
        decoration: const InputDecoration(
          labelText: 'Ingredients',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.specifics,
        decoration: const InputDecoration(
          labelText: 'Specifics',
        ),
      ),
      TextFormField(
        style: _text,
        readOnly: true,
        initialValue: beer.beerNotes,
        decoration: const InputDecoration(
          labelText: 'Beer Notes',
        ),
      ),
    ];
  }
}

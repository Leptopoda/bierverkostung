// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart'
    show ThousandsFormatter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bierverkostung/models/beers.dart';

/// Display the given [beer]
class DispBeer {
  final Beer beer;

  const DispBeer({
    required this.beer,
  });

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  /// builds a List of widgets to display beer information
  List<Widget> dispBeer(BuildContext context) {
    final List<Widget> _beerInfo = [
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
    if (beer.images == null) {
      return _beerInfo;
    } else {
      return _beerInfo
        ..addAll([
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: 500,
            child: _BeerImage(
              imagePaths: beer.images!,
            ),
          ),
        ]);
    }
  }
}

/// Widget to display Images of a beer
class _BeerImage extends StatelessWidget {
  final List<String> imagePaths;
  const _BeerImage({
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
          color: Colors.amber,
          child: Image.network(imagePaths[i]),
        );
      },
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/models/beer_styles.dart';
import 'package:bierverkostung/models/breweries.dart';

class Beer {
  // final String id;
  // final int revision;
  final String beerName;
  final Brewery? brewery;
  final BeerStyle? style;
  final String? originalWort;
  final String? alcohol;
  final int? ibu;
  final String? ingredients;
  final String? specifics;
  final String? beerNotes;

  Beer(
      {required this.beerName,
      this.brewery,
      this.style,
      this.originalWort,
      this.alcohol,
      this.ibu,
      this.ingredients,
      this.specifics,
      this.beerNotes});
}

// CREATE TABLE beers (_id TEXT PRIMARY KEY, _revision INTEGER, beer_name TEXT NOT NULL, brewery_id TEXT, style_id TEXT, original_wort TEXT, alcohol TEXT, ibu INTEGER, ingredients TEXT, specifics TEXT, beer_notes TEXT, FOREIGN KEY (style_id) REFERENCES beer_styles(_id), FOREIGN KEY (brewery_id) REFERENCES breweries(_id))

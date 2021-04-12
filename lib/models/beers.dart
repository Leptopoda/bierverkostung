// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/models/beer_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bierverkostung/models/breweries.dart';

class Beer {
  // final String id;
  // final int revision;
  final String beerName;
  final Brewery? brewery;
  final BeerStyle? style;
  final String? originalWort;
  final double? alcohol;
  final int? ibu;
  final String? ingredients;
  final String? specifics;
  final String? beerNotes;

  Beer({
    required this.beerName,
    this.brewery,
    this.style,
    this.originalWort,
    this.alcohol,
    this.ibu,
    this.ingredients,
    this.specifics,
    this.beerNotes,
  });

  factory Beer.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()!;

    return Beer(
      beerName: data['beerName'] as String,
      brewery: data['brewery'] as Brewery?,
      style: data['style'] as BeerStyle?,
      originalWort: data['originalWort'] as String?,
      alcohol: data['alcohol'] as double?,
      ibu: data['ibu'] as int?,
      ingredients: data['ingredients'] as String?,
      specifics: data['specifics'] as String?,
      beerNotes: data['beerNotes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'beerName': beerName,
      'brewery': brewery,
      'style': style,
      'originalWort': originalWort,
      'alcohol': alcohol,
      'ibu': ibu,
      'ingredients': ingredients,
      'specifics': specifics,
      'beerNotes': beerNotes,
    };
  }
}

// CREATE TABLE beers (_id TEXT PRIMARY KEY, _revision INTEGER, beer_name TEXT NOT NULL, brewery_id TEXT, style_id TEXT, original_wort TEXT, alcohol TEXT, ibu INTEGER, ingredients TEXT, specifics TEXT, beer_notes TEXT, FOREIGN KEY (style_id) REFERENCES beer_styles(_id), FOREIGN KEY (brewery_id) REFERENCES breweries(_id))

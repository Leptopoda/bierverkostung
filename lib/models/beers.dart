// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:bierverkostung/models/breweries.dart';

class Beer {
  // final String id;
  // final int revision;
  final String beerName;
  final Brewery? brewery;
  final String? style;
  final double? originalWort;
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
      brewery: (data['breweryName'] != null)
          ? Brewery.fromMap(data['brewery'])
          : null,
      style: data['style'] as String?,
      originalWort: data['originalWort'] as double?,
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
      'brewery': brewery?.toMap(),
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
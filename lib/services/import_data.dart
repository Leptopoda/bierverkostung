// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/breweries.dart';
import 'package:bierverkostung/models/tastings.dart';

class ImportDataService {
  void parseJson(Map data) {
    final _brewery = Brewery(
      breweryName: data['beer']['name'] as String,
      breweryLocation: data['beer']['location'] as String?,
      country: data['beer']['country']['name'] as String?,
    );

    final _beer = Beer(
      beerName: data['name'] as String,
      brewery: _brewery,
      style: data['style']['name'] as String?,
      originalWort: data['originalWort'] as double?,
      alcohol: data['alcohol'] as double?,
      ibu: data['ibu'] as int?,
      ingredients: data['ingredients'] as String?,
      specifics: data['specifics'] as String?,
      beerNotes: data['notes'] as String?,
    );

    final _tasting = Tasting(
      date: data['date'].toDate() as DateTime,
      beer: _beer,
      location: data['location'] as String?,
      beerColour: data['opticalAppearance']['beerColour'] as String?,
      beerColourDesc: data['opticalAppearance']['beerColourDescription'] as String?,
      colourEbc: data['opticalAppearance']['ebc'] as int,
      clarity: data['opticalAppearance']['clarityDescription'] as String?,
      foamColour: data['opticalAppearance']['foamColour'] as String?,
      foamStructure: data['opticalAppearance']['foamStructureDescription'] as String?,
      foamStability: data['opticalAppearance']['foamStability'] as int,
      bitternessRating: data['taste']['bitternessRating'] as int,
      sweetnessRating: data['taste']['sweetnessRating'] as int,
      acidityRating: data['taste']['acidityRating'] as int,
      mouthFeelDesc: data['taste']['mouthfeelDescription'] as String?,
      fullBodiedRating: data['taste']['fullBodiedRating'] as int,
      bodyDesc: data['taste']['bodyDescription'] as String?,
      aftertasteDesc: data['taste']['aftertaste']['description'] as String?,
      aftertasteRating: data['taste']['aftertaste']['rating'] as int,
      foodRecommendation: data['foodRecommendation'] as String?,
      totalImpressionDesc: data['totalImpressionDescription'] as String?,
      totalImpressionRating: data['totalImpressionDescription'] as int,
    );
  }
}

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bierverkostung/models/beers.dart';

class Tasting {
  // final String id;
  // final int revision;
  DateTime date;
  String? location;
  Beer beer;
  String? beerColour;
  String? beerColourDesc;
  int colourEbc;
  String? clarity;
  String? foamColour;
  String? foamStructure;
  int foamStability;
  int bitternessRating;
  int sweetnessRating;
  int acidityRating;
  String? mouthFeelDesc;
  int fullBodiedRating;
  String? bodyDesc;
  String? aftertasteDesc;
  int aftertasteRating;
  String? foodRecommendation;
  String? totalImpressionDesc;
  int totalImpressionRating;

  Tasting({
    required this.date,
    required this.beer,
    this.location,
    this.beerColour,
    this.beerColourDesc,
    this.colourEbc = 4,
    this.clarity,
    this.foamColour,
    this.foamStructure,
    this.foamStability = 1,
    this.bitternessRating = 1,
    this.sweetnessRating = 1,
    this.acidityRating = 1,
    this.mouthFeelDesc,
    this.fullBodiedRating = 1,
    this.bodyDesc,
    this.aftertasteDesc,
    this.aftertasteRating = 1,
    this.foodRecommendation,
    this.totalImpressionDesc,
    this.totalImpressionRating = 1,
  });

  factory Tasting.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()!;

    return Tasting(
      // id: doc.data(),
      date: data['date'].toDate() as DateTime,
      beer: Beer(beerName: data['beer'] as String),
      location: data['location'] as String?,
      beerColour: data['beerColour'] as String?,
      beerColourDesc: data['beerColourDesc'] as String?,
      colourEbc: data['colourEbc'] as int,
      clarity: data['clarity'] as String?,
      foamColour: data['foamColour'] as String?,
      foamStructure: data['foamStructure'] as String?,
      foamStability: data['foamStability'] as int,
      bitternessRating: data['bitternessRating'] as int,
      sweetnessRating: data['sweetnessRating'] as int,
      acidityRating: data['acidityRating'] as int,
      mouthFeelDesc: data['mouthFeelDesc'] as String?,
      fullBodiedRating: data['fullBodiedRating'] as int,
      bodyDesc: data['bodyDesc'] as String?,
      aftertasteDesc: data['aftertasteDesc'] as String?,
      aftertasteRating: data['aftertasteRating'] as int,
      foodRecommendation: data['foodRecommendation'] as String?,
      totalImpressionDesc: data['totalImpressionDesc'] as String?,
      totalImpressionRating: data['totalImpressionRating'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'beer': beer.beerName,
      'location': location,
      'beerColour': beerColour,
      'beerColourDesc': beerColourDesc,
      'colourEbc': colourEbc,
      'clarity': clarity,
      'foamColour': foamColour,
      'foamStructure': foamStructure,
      'foamStability': foamStability,
      'bitternessRating': bitternessRating,
      'sweetnessRating': sweetnessRating,
      'acidityRating': acidityRating,
      'mouthFeelDesc': mouthFeelDesc,
      'fullBodiedRating': fullBodiedRating,
      'bodyDesc': bodyDesc,
      'aftertasteDesc': aftertasteDesc,
      'aftertasteRating': aftertasteRating,
      'foodRecommendation': foodRecommendation,
      'totalImpressionDesc': totalImpressionDesc,
      'totalImpressionRating': totalImpressionRating,
    };
  }
}

// CREATE TABLE tastings (_id TEXT PRIMARY KEY, _revision INTEGER, date TEXT, location TEXT, beer_id TEXT, beer_colour TEXT, beer_colour_desc TEXT, colour_ebc INTEGER, clarity TEXT, foam_colour TEXT, foam_structure TEXT, foam_stability INTEGER, fruit_desc TEXT, fruit_rating INTEGER, flower_desc TEXT, flower_rating INTEGER, vegetal_desc TEXT, vegetal_rating INTEGER, spicy_desc TEXT, spicy_rating INTEGER, warmth_minted_desc TEXT, warmth_minted_rating INTEGER, biological_desc TEXT, biological_rating INTEGER, bitterness_rating INTEGER, sweetness_rating INTEGER, acidity_rating INTEGER, mouth_feel_desc TEXT, full_bodied_rating INTEGER, body_desc TEXT, aftertaste_desc TEXT, aftertaste_rating INTEGER, food_recommendation TEXT, total_impression_desc TEXT, total_impression_rating INTEGER, FOREIGN KEY (beer_id) REFERENCES beers(_id))

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' show immutable;
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:json_annotation/json_annotation.dart';

import 'package:bierverkostung/models/beers.dart';

part 'tastings.g.dart';

/// Tasting data Model
///
/// This Class holds the data of a BeerTasting
@JsonSerializable()
@immutable
class Tasting {
  // final String id;
  // final int revision;
  final DateTime date;
  final String? location;
  final Beer beer;
  final String? beerColour;
  final String? beerColourDesc;
  final int? colourEbc;
  final String? clarity;
  final String? foamColour;
  final String? foamStructure;
  final int foamStability;
  final int bitternessRating;
  final int sweetnessRating;
  final int acidityRating;
  final String? mouthFeelDesc;
  final int fullBodiedRating;
  final String? bodyDesc;
  final String? aftertasteDesc;
  final int aftertasteRating;
  final String? foodRecommendation;
  final String? totalImpressionDesc;
  final int totalImpressionRating;

  const Tasting({
    required this.date,
    required this.beer,
    this.location,
    this.beerColour,
    this.beerColourDesc,
    this.colourEbc,
    this.clarity,
    this.foamColour,
    this.foamStructure,
    this.foamStability = 0,
    this.bitternessRating = 0,
    this.sweetnessRating = 0,
    this.acidityRating = 0,
    this.mouthFeelDesc,
    this.fullBodiedRating = 0,
    this.bodyDesc,
    this.aftertasteDesc,
    this.aftertasteRating = 0,
    this.foodRecommendation,
    this.totalImpressionDesc,
    this.totalImpressionRating = 0,
  });

  /// encodes a Json style map into a [Tasting] obbject
  factory Tasting.fromJson(Map<String, dynamic> json) =>
      _$TastingFromJson(json);

  /// decodes a Json from a [UserData] obbject
  Map<String, dynamic> toJson() => _$TastingToJson(this);

  /// decodes a Json style map into a [Tasting] obbject
  @Deprecated('use from and to json for en/decode')
  factory Tasting.fromMap(Map data) {
    return Tasting(
      date: (data['date'] is Timestamp)
          ? data['date'].toDate() as DateTime
          : DateTime.parse(data['date'] as String),
      // ignore: deprecated_member_use_from_same_package
      beer: Beer.fromMap(data['beer'] as Map),
      location: data['location'] as String?,
      beerColour: data['opticalAppearance']?['beerColour'] as String?,
      beerColourDesc:
          data['opticalAppearance']?['beerColourDescription'] as String?,
      colourEbc: data['opticalAppearance']?['ebc'] as int?,
      clarity: data['opticalAppearance']?['clarityDescription'] as String?,
      foamColour: data['opticalAppearance']?['foamColour'] as String?,
      foamStructure:
          data['opticalAppearance']?['foamStructureDescription'] as String?,
      foamStability: (data['opticalAppearance']?['foamStability'] != null)
          ? data['opticalAppearance']['foamStability'] as int
          : 0,
      bitternessRating: (data['taste']?['bitternessRating'] != null)
          ? data['taste']['bitternessRating'] as int
          : 0,
      sweetnessRating: (data['taste']?['sweetnessRating'] != null)
          ? data['taste']['sweetnessRating'] as int
          : 0,
      acidityRating: (data['taste']?['acidityRating'] != null)
          ? data['taste']['acidityRating'] as int
          : 0,
      mouthFeelDesc: data['taste']?['mouthfeelDescription'] as String?,
      fullBodiedRating: (data['taste']?['fullBodiedRating'] != null)
          ? data['taste']['fullBodiedRating'] as int
          : 0,
      bodyDesc: data['taste']?['bodyDescription'] as String?,
      aftertasteDesc: data['taste']?['aftertaste']?['description'] as String?,
      aftertasteRating: (data['taste']?['aftertaste']?['rating'] != null)
          ? data['taste']['aftertaste']['rating'] as int
          : 0,
      foodRecommendation: data['foodRecommendation'] as String?,
      totalImpressionDesc: data['totalImpressionDescription'] as String?,
      totalImpressionRating: data['totalImpressionRating'] as int,
    );
  }

  /// encodes a Json style map into a [Tasting] obbject
  @Deprecated('use from and to json for en/decode')
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'beer': beer.toMap(),
      'location': location,
      'opticalAppearance': {
        'beerColour': beerColour,
        'beerColourDesc': beerColourDesc,
        'colourEbc': colourEbc,
        'clarity': clarity,
        'foamColour': foamColour,
        'foamStructure': foamStructure,
        'foamStability': foamStability,
      },
      'taste': {
        'bitternessRating': bitternessRating,
        'sweetnessRating': sweetnessRating,
        'acidityRating': acidityRating,
        'mouthFeelDesc': mouthFeelDesc,
        'fullBodiedRating': fullBodiedRating,
        'bodyDesc': bodyDesc,
        'aftertaste': {
          'aftertasteDesc': aftertasteDesc,
          'aftertasteRating': aftertasteRating,
        },
      },
      'foodRecommendation': foodRecommendation,
      'totalImpressionDescription': totalImpressionDesc,
      'totalImpressionRating': totalImpressionRating,
    };
  }
}

// CREATE TABLE tastings (_id TEXT PRIMARY KEY, _revision INTEGER, date TEXT, location TEXT, beer_id TEXT, beer_colour TEXT, beer_colour_desc TEXT, colour_ebc INTEGER, clarity TEXT, foam_colour TEXT, foam_structure TEXT, foam_stability INTEGER, fruit_desc TEXT, fruit_rating INTEGER, flower_desc TEXT, flower_rating INTEGER, vegetal_desc TEXT, vegetal_rating INTEGER, spicy_desc TEXT, spicy_rating INTEGER, warmth_minted_desc TEXT, warmth_minted_rating INTEGER, biological_desc TEXT, biological_rating INTEGER, bitterness_rating INTEGER, sweetness_rating INTEGER, acidity_rating INTEGER, mouth_feel_desc TEXT, full_bodied_rating INTEGER, body_desc TEXT, aftertaste_desc TEXT, aftertaste_rating INTEGER, food_recommendation TEXT, total_impression_desc TEXT, total_impression_rating INTEGER, FOREIGN KEY (beer_id) REFERENCES beers(_id))

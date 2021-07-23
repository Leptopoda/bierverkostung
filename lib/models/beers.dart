// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

import 'package:bierverkostung/models/breweries.dart';

part 'beers.g.dart';

/// Beer data model
///
/// holds the data needed for a beer
@JsonSerializable()
@immutable
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
  final List<String>? images;

  const Beer({
    required this.beerName,
    this.brewery,
    this.style,
    this.originalWort,
    this.alcohol,
    this.ibu,
    this.ingredients,
    this.specifics,
    this.beerNotes,
    this.images,
  });

  /// decodes a Json into a [Beer] obbject
  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);

  /// encodes a Json from a [Beer] obbject
  Map<String, dynamic> toJson() => _$BeerToJson(this);

  /// decodes a Json style map into a [Beer] obbject
  @Deprecated('use from and to json for en/decode')
  factory Beer.fromMap(Map data) {
    return Beer(
      beerName: data['name'] as String,
      brewery: (data['brewery'] != null)
          // ignore: deprecated_member_use_from_same_package
          ? Brewery.fromMap(data['brewery'] as Map)
          : null,
      style: data['style']?['name'] as String?,
      originalWort: double.tryParse(data['originalWort'].toString()),
      alcohol: double.tryParse(data['alcohol'].toString()),
      ibu: data['ibu'] as int?,
      ingredients: data['ingredients'] as String?,
      specifics: data['specifics'] as String?,
      beerNotes: data['notes'] as String?,
      images: data['imageUrls'] as List<String>?,
    );
  }

  /// encodes a Json style map into a [Beer] obbject
  @Deprecated('use from and to json for en/decode')
  Map<String, dynamic> toMap() {
    return {
      'name': beerName,
      'brewery': brewery?.toMap(),
      'style': {
        'style': style,
      },
      'originalWort': originalWort,
      'alcohol': alcohol,
      'ibu': ibu,
      'ingredients': ingredients,
      'specifics': specifics,
      'notes': beerNotes,
    };
  }
}

// CREATE TABLE beers (_id TEXT PRIMARY KEY, _revision INTEGER, beer_name TEXT NOT NULL, brewery_id TEXT, style_id TEXT, original_wort TEXT, alcohol TEXT, ibu INTEGER, ingredients TEXT, specifics TEXT, beer_notes TEXT, FOREIGN KEY (style_id) REFERENCES beer_styles(_id), FOREIGN KEY (brewery_id) REFERENCES breweries(_id))

// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'breweries.g.dart';

/// Brevery data model
///
/// Holds the data describing a brewery
@JsonSerializable()
class Brewery {
  // final String id;
  // final int revision;
  final String breweryName;
  final String? breweryLocation;
  final String? country;

  Brewery({
    required this.breweryName,
    this.breweryLocation,
    this.country,
  });

  /// decodes a Json into a [Brewerie] obbject
  factory Brewery.fromJson(Map<String, dynamic> json) =>
      _$BreweryFromJson(json);

  /// encodes a Json from a [Brewerie] obbject
  Map<String, dynamic> toJson() => _$BreweryToJson(this);

  /// decodes a Json style map into a [Brewerie] obbject
  @Deprecated('use from and to json for en/decode')
  factory Brewery.fromMap(Map data) {
    return Brewery(
      breweryName: data['name'] as String,
      breweryLocation: data['location'] as String?,
      country: data['country']?['name'] as String?,
    );
  }

  /// encodes a Json style map into a [Brewerie] obbject
  @Deprecated('use from and to json for en/decode')
  Map<String, dynamic> toMap() {
    return {
      'name': breweryName,
      'location': breweryLocation,
      'country': {
        'name': country,
      },
    };
  }
}

// CREATE TABLE breweries (_id TEXT PRIMARY KEY, _revision INTEGER, brewery_name TEXT NOT NULL, brewery_location TEXT, country_id TEXT, FOREIGN KEY (country_id) REFERENCES countries(_id))

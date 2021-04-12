// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Brewery.fromMap(dynamic data) {
    return Brewery(
      breweryName: data['breweryName'] as String,
      breweryLocation: data['breweryLocation'] as String?,
      country: data['country'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'breweryName': breweryName,
      'breweryLocation': breweryLocation,
      'country': country,
    };
  }
}

// CREATE TABLE breweries (_id TEXT PRIMARY KEY, _revision INTEGER, brewery_name TEXT NOT NULL, brewery_location TEXT, country_id TEXT, FOREIGN KEY (country_id) REFERENCES countries(_id))

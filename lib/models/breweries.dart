// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

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
}

// CREATE TABLE breweries (_id TEXT PRIMARY KEY, _revision INTEGER, brewery_name TEXT NOT NULL, brewery_location TEXT, country_id TEXT, FOREIGN KEY (country_id) REFERENCES countries(_id))

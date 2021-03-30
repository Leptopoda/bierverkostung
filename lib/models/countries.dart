// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

class Country {
  // final String id;
  // final int revision;
  final String countryName;

  Country({required this.countryName});
}

// CREATE TABLE countries (_id TEXT PRIMARY KEY, _revision INTEGER, country_name TEXT UNIQUE NOT NULL)

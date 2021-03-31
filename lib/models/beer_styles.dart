// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

class BeerStyle {
  // final String id;
  // final int revision;
  final String beerStyleName;

  BeerStyle({
    required this.beerStyleName,
  });
}

// CREATE TABLE beer_styles (_id TEXT PRIMARY KEY, _revision INTEGER, beer_style_name TEXT UNIQUE NOT NULL)

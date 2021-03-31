// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/models/beers.dart';

class Tasting {
  // final String id;
  // final int revision;
  final DateTime date;
  final String? location;
  final Beer beer;
  // beer_colour TEXT,
  // beer_colour_desc TEXT,
  // colour_ebc INTEGER,
  // clarity TEXT,
  // foam_colour TEXT,
  // foam_structure TEXT,
  // foam_stability INTEGER,
  // fruit_desc TEXT,
  // fruit_rating INTEGER,
  // flower_desc TEXT,
  // flower_rating INTEGER,
  // vegetal_desc TEXT,
  // vegetal_rating INTEGER,
  // spicy_desc TEXT,
  // spicy_rating INTEGER,
  // warmth_minted_desc TEXT,
  // warmth_minted_rating INTEGER,
  // biological_desc TEXT,
  // biological_rating INTEGER,
  // bitterness_rating INTEGER,
  // sweetness_rating INTEGER,
  // acidity_rating INTEGER,
  // mouth_feel_desc TEXT,
  // full_bodied_rating INTEGER,
  // body_desc TEXT,
  // aftertaste_desc TEXT,
  // aftertaste_rating INTEGER,
  // food_recommendation TEXT,
  // total_impression_desc TEXT,
  // total_impression_rating INTEGER,

  Tasting({
    required this.date,
    required this.beer,
    this.location,
  });
}

// CREATE TABLE tastings (_id TEXT PRIMARY KEY, _revision INTEGER, date TEXT, location TEXT, beer_id TEXT, beer_colour TEXT, beer_colour_desc TEXT, colour_ebc INTEGER, clarity TEXT, foam_colour TEXT, foam_structure TEXT, foam_stability INTEGER, fruit_desc TEXT, fruit_rating INTEGER, flower_desc TEXT, flower_rating INTEGER, vegetal_desc TEXT, vegetal_rating INTEGER, spicy_desc TEXT, spicy_rating INTEGER, warmth_minted_desc TEXT, warmth_minted_rating INTEGER, biological_desc TEXT, biological_rating INTEGER, bitterness_rating INTEGER, sweetness_rating INTEGER, acidity_rating INTEGER, mouth_feel_desc TEXT, full_bodied_rating INTEGER, body_desc TEXT, aftertaste_desc TEXT, aftertaste_rating INTEGER, food_recommendation TEXT, total_impression_desc TEXT, total_impression_rating INTEGER, FOREIGN KEY (beer_id) REFERENCES beers(_id))

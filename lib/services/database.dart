// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  // TODO: probably move to kv-store
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();

  _getDB() async {
    final Future<Database> _database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'bierverkostung.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE _konsum ("
          "_id	INTEGER,"
          "menge	DOUBLE,"
          "timestamp	DATE DEFAULT (date('now')),"
          "PRIMARY KEY(_id AUTOINCREMENT)"
          ")",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return _database;
  }

  insertKonsum(double groesse) async {
    print(groesse);
    final db = await _getDB();
    var result = await db
        .rawInsert("INSERT INTO _konsum ('menge') VALUES (?)", [groesse]);
    return result;
  }

  Future<List<Map>> getAllKonsum() async {
    final db = await _getDB();
    List<Map> results = await db.query("_konsum",
        columns: ["menge", "timestamp"], orderBy: "date(timestamp)");
    /* List<Product> products = new List();
    results.forEach((result) {
      Product product = Product.fromMap(result);
      products.add(product);
    }); */
    return results;
  }
}

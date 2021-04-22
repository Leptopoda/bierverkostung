// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:developer' as developer show log;
import 'dart:io';

import 'package:bierverkostung/services/database.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/breweries.dart';
import 'package:bierverkostung/models/tastings.dart';
import 'package:bierverkostung/models/users.dart';

class ImportDataService {
  final UserData user;
  ImportDataService({required this.user});

  Future importData(File archive) async {
    try {
      final Directory _tempDir = await getTemporaryDirectory();
      final Directory _dataDir =
          Directory('${_tempDir.path}/import/${DateTime.now()}');

      await ZipFile.extractToDirectory(
        zipFile: archive,
        destinationDir: _dataDir,
        /* onExtracting: (zipEntry, progress) {
              print('progress: ${progress.toStringAsFixed(1)}%');
              print('name: ${zipEntry.name}');
              print('isDirectory: ${zipEntry.isDirectory}');
              print(
                  'modificationDate: ${zipEntry.modificationDate?.toLocal().toIso8601String()}');
              print('uncompressedSize: ${zipEntry.uncompressedSize}');
              print('compressedSize: ${zipEntry.compressedSize}');
              print('compressionMethod: ${zipEntry.compressionMethod}');
              print('crc: ${zipEntry.crc}');
              return ExtractOperation.extract;
            }*/
      );
      await _dataDir.list().forEach((file) async {
        if (file is File) {
          await _parseJson(file);
        } else {
          developer.log(
            'did not import some files',
            name: 'leptopoda.bierverkostung.importDataService',
            error: jsonEncode(file.toString()),
          );
        }
      });

      _dataDir.deleteSync(recursive: true);
    } catch (error) {
      developer.log(
        'error restoring backup',
        name: 'leptopoda.bierverkostung.importDataService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  Future<void> _parseJson(File file) async {
    try {
      final String _contents = await file.readAsString();
      final Map _data = jsonDecode(_contents) as Map;

      final _brewery = Brewery(
        breweryName: _data['beer']?['brewery']?['name'] as String,
        breweryLocation: _data['beer']?['brewery']?['location'] as String?,
        country: _data['beer']?['brewery']?['country']?['name'] as String?,
      );

      final _beer = Beer(
        beerName: _data['beer']?['name'] as String,
        brewery: _brewery,
        style: _data['beer']?['style']?['name'] as String?,
        originalWort: double?.tryParse((_data['beer']?['originalWort'] != null)
            ? _data['beer']['originalWort'] as String
            : ''),
        alcohol: double?.tryParse((_data['beer']?['alcohol'] != null)
            ? _data['beer']['alcohol'] as String
            : ''),
        ibu: _data['beer']?['ibu'] as int?,
        ingredients: _data['beer']?['ingredients'] as String?,
        specifics: _data['beer']?['specifics'] as String?,
        beerNotes: _data['beer']?['notes'] as String?,
      );

      final _tasting = Tasting(
        date: DateTime.parse(_data['date'] as String),
        beer: _beer,
        location: _data['location'] as String?,
        beerColour: _data['opticalAppearance']?['beerColour'] as String?,
        beerColourDesc:
            _data['opticalAppearance']?['beerColourDescription'] as String?,
        colourEbc: _data['opticalAppearance']?['ebc'] as int?,
        clarity: _data['opticalAppearance']?['clarityDescription'] as String?,
        foamColour: _data['opticalAppearance']?['foamColour'] as String?,
        foamStructure:
            _data['opticalAppearance']?['foamStructureDescription'] as String?,
        foamStability: (_data['opticalAppearance']?['foamStability'] != null)
            ? _data['opticalAppearance']['foamStability'] as int
            : 0,
        bitternessRating: (_data['taste']?['bitternessRating'] != null)
            ? _data['taste']['bitternessRating'] as int
            : 0,
        sweetnessRating: (_data['taste']?['sweetnessRating'] != null)
            ? _data['taste']['sweetnessRating'] as int
            : 0,
        acidityRating: (_data['taste']?['acidityRating'] != null)
            ? _data['taste']['acidityRating'] as int
            : 0,
        mouthFeelDesc: _data['taste']?['mouthfeelDescription'] as String?,
        fullBodiedRating: (_data['taste']?['fullBodiedRating'] != null)
            ? _data['taste']['fullBodiedRating'] as int
            : 0,
        bodyDesc: _data['taste']?['bodyDescription'] as String?,
        aftertasteDesc:
            _data['taste']?['aftertaste']?['description'] as String?,
        aftertasteRating: (_data['taste']?['aftertaste']?['rating'] != null)
            ? _data['taste']['aftertaste']['rating'] as int
            : 0,
        foodRecommendation: _data['foodRecommendation'] as String?,
        totalImpressionDesc: _data['totalImpressionDescription'] as String?,
        totalImpressionRating: _data['totalImpressionRating'] as int,
      );

      print(_beer.alcohol);
      DatabaseService(user: user).saveBeer(_beer);
      DatabaseService(user: user).saveTasting(_tasting);
    } catch (error) {
      developer.log(
        'error parsing json',
        name: 'leptopoda.bierverkostung.importDataService',
        error: jsonEncode('{error: ${error.toString()}, file: $file}'),
      );
    }
  }
}

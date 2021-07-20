// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/import_data_settings.dart';

/// The backend servie for omporting
///
/// Responsible for extracting, parsing and saving the data
class _ImportDataService {
  const _ImportDataService._();

  /// imports the data of the picked file
  static Future<void> importData(File archive) async {
    try {
      final Directory _tempDir = await getTemporaryDirectory();
      final Directory _dataDir =
          Directory('${_tempDir.path}/import/${DateTime.now()}');

      await ZipFile.extractToDirectory(
        zipFile: archive,
        destinationDir: _dataDir,
        /* 
        onExtracting: (zipEntry, progress) {
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
            }
        */
      );

      await _dataDir.list().forEach((file) async {
        if (file is File) {
          await _parseJson(file, _dataDir);
        }
      });

      // await _dataDir.delete(recursive: true);
    } catch (error) {
      developer.log(
        'error restoring backup',
        name: 'leptopoda.bierverkostung.importDataService',
        error: jsonEncode(error.toString()),
      );
    }
  }

  /// parses the imported JSON data and saves it
  static Future<void> _parseJson(File file, Directory dataDir) async {
    try {
      final String _contents = await file.readAsString();
      // TODO: validate json (maybe externalize to cloud function)
      final Map _data = jsonDecode(_contents) as Map;

      final List? _photos = _data['beer']['photos'] as List?;
      final List<String> _imageUrls = [];
      if (_photos != null) {
        for (final element in _photos) {
          final String? _url = await CloudStorageService.uploadBeerImage(
              '${dataDir.path}/photos/beer/${element['photo_file']['name']}',
              _data['beer']['name'] as String);
          if (_url != null) {
            _imageUrls.add(_url);
          }
        }
        _data['imageUrls'] = _imageUrls;
      }

      DatabaseService.saveBeer(
          // ignore: deprecated_member_use_from_same_package
          Beer.fromMap(_data['beer'] as Map<String, dynamic>));
      DatabaseService.saveTasting(
          // ignore: deprecated_member_use_from_same_package
          Tasting.fromMap(_data as Map<String, dynamic>));
    } catch (error) {
      developer.log(
        'error parsing json',
        name: 'leptopoda.bierverkostung.importDataService',
        error: jsonEncode('{error: ${error.toString()}, $file}'),
      );
    }
  }
}

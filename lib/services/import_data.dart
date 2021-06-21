// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/settings/import_data_settings.dart';

class _ImportDataService {
  const _ImportDataService();

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

  static Future<void> _parseJson(File file) async {
    try {
      final String _contents = await file.readAsString();
      final Map _data = jsonDecode(_contents) as Map;

      // TODO: validate json (maybe externalize to cloud function)
      DatabaseService.saveBeer(
          Beer.fromMap(_data['beer'] as Map<String, dynamic>));
      DatabaseService.saveTasting(
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

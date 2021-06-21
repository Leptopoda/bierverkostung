// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:developer' as developer show log;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bierverkostung/services/firebase/database.dart';
import 'package:bierverkostung/models/beers.dart';
import 'package:bierverkostung/models/tastings.dart';

part 'package:bierverkostung/services/import_data.dart';

class ImportDataSettings extends StatelessWidget {
  const ImportDataSettings({Key? key}) : super(key: key);

  static const TextStyle _text = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: Text(
              AppLocalizations.of(context)!.settings_importData_desc,
              style: _text,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _importData(context),
            icon: const Icon(Icons.import_export_outlined),
            label: Text(AppLocalizations.of(context)!.settings_importData),
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.settings_importData_web,
          style: _text,
        ),
      );
    }
  }

  static Future _importData(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result?.files.single.path != null) {
      final File _zipFile = File(result!.files.single.path!);
      await _ImportDataService.importData(_zipFile);
    } else {
      developer.log(
        'error getting file',
        name: 'leptopoda.bierverkostung.importDataSettings',
      );
    }
  }
}
